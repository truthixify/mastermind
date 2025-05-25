pub mod enums;
pub mod interface;
pub mod structs;

#[starknet::contract]
pub mod Mastermind {
    use core::array::ArrayTrait;
    use core::hash::HashStateTrait;
    use core::poseidon::PoseidonTrait;
    use mastermind::enums::{GameResult, Stages};
    use mastermind::interface::IMastermind;
    use mastermind::structs::{Game, Guess, HitAndBlow, Player};
    use starknet::event::EventEmitter;
    use starknet::storage::{
        Map, MutableVecTrait, StoragePathEntry, StoragePointerReadAccess, StoragePointerWriteAccess,
        VecTrait,
    };
    use starknet::{ContractAddress, SyscallResultTrait, get_caller_address, syscalls};

    pub const MAX_ROUND: u64 = 10;
    pub const VERIFIER_CLASSHASH: felt252 =
        0x057f6a6bda4e2ee16424f38a5c784dc31fc3c9dcfc0c8388fac4ba159a610edf;

    #[storage]
    pub struct Storage {
        pub games: Map<u32, Game>,
        pub players: Map<ContractAddress, Player>,
        pub total_games_count: u32,
        pub total_players_count: u32,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event {
        InitializeGame: InitializeGame,
        RegisterPlayer: RegisterPlayer,
        CommitSolutionHash: CommitSolutionHash,
        SubmitGuess: SubmitGuess,
        SubmitHitAndBlow: SubmitHitAndBlow,
        RevealSolution: RevealSolution,
        GameFinish: GameFinish,
        StageChange: StageChange,
        OpponentJoined: OpponentJoined,
    }

    #[derive(Drop, starknet::Event)]
    pub struct InitializeGame {
        pub account: ContractAddress,
        pub game_id: u32,
    }

    #[derive(Drop, starknet::Event)]
    pub struct RegisterPlayer {
        pub account: ContractAddress,
        pub player_id: u32,
    }

    #[derive(Drop, starknet::Event)]
    pub struct CommitSolutionHash {
        pub account: ContractAddress,
        pub solution_hash: u256,
    }

    #[derive(Drop, starknet::Event)]
    pub struct SubmitGuess {
        pub account: ContractAddress,
        pub current_round: u8,
        pub guess: Array<u8>,
    }

    #[derive(Drop, starknet::Event)]
    pub struct SubmitHitAndBlow {
        pub account: ContractAddress,
        pub current_round: u8,
        pub hit: u8,
        pub blow: u8,
    }

    #[derive(Drop, starknet::Event)]
    pub struct RevealSolution {
        pub account: ContractAddress,
        pub solution: Array<u8>,
    }

    #[derive(Drop, starknet::Event)]
    pub struct GameFinish {
        pub game_result: GameResult,
    }

    #[derive(Drop, starknet::Event)]
    pub struct StageChange {
        pub stage: Stages,
    }

    #[derive(Drop, starknet::Event)]
    pub struct OpponentJoined {
        pub account: ContractAddress,
        pub game_id: u32,
    }

    #[constructor]
    pub fn constructor(ref self: ContractState) {}

    #[abi(embed_v0)]
    impl MasterMindImpl of IMastermind<ContractState> {
        fn register_player(ref self: ContractState, player_name: felt252) {
            let caller = get_caller_address();
            let prev_total_players_count = self.total_players_count.read();

            let player = self.players.entry(caller);

            assert!(player.player_id.read() == 0, "User already registered");

            player.player_id.write(prev_total_players_count);
            player.player_name.write(player_name);
            self.total_players_count.write(prev_total_players_count + 1);

            self
                .emit(
                    Event::RegisterPlayer(
                        RegisterPlayer { account: caller, player_id: prev_total_players_count },
                    ),
                );
        }

        fn init_game(ref self: ContractState) {
            let creator_address = get_caller_address();
            let player_id = self.players.entry(creator_address).player_id.read();
            let total_players_count = self.total_players_count.read();

            assert!(
                player_id >= 0 && total_players_count > 0,
                "You need to register first before you can start a game",
            );

            let prev_total_games_count = self.total_games_count.read();
            let new_game = self.games.entry(prev_total_games_count);
            let player = self.players.entry(creator_address);

            new_game.game_id.write(prev_total_games_count);
            new_game.stage.write(Stages::CreatorCommitSolutionHash);
            new_game.current_round.write(1);
            new_game.creator.write(creator_address);
            player.player_game_ids.push(prev_total_games_count);
            self.total_games_count.write(prev_total_games_count + 1);

            self
                .emit(
                    Event::InitializeGame(
                        InitializeGame {
                            account: creator_address, game_id: prev_total_games_count,
                        },
                    ),
                );
        }

        fn join_game(ref self: ContractState, game_id: u32) {
            let game = self.games.entry(game_id);
            let opponent_address = get_caller_address();
            let player_id = self.players.entry(opponent_address).player_id.read();
            let player = self.players.entry(opponent_address);
            let total_players_count = self.total_players_count.read();

            assert!(
                player_id >= 0 && total_players_count > 0,
                "You need to register first before you can start a game",
            );
            assert!(game.creator.read() != opponent_address, "You cannot join your own game");
            assert!(game.opponent.read() == 0x0.try_into().unwrap(), "Opponent already joined");

            if game.stage.read() == Stages::WaitingForOpponent {
                game.opponent.write(opponent_address);
                game.stage.write(Stages::OpponentCommitSolutionHash);
                player.player_game_ids.push(game_id);

                self
                    .emit(
                        Event::OpponentJoined(
                            OpponentJoined { account: opponent_address, game_id },
                        ),
                    )
            }
        }

        fn commit_solution_hash(ref self: ContractState, game_id: u32, solution_hash: u256) {
            let game = self.games.entry(game_id);
            let creator_address = game.creator.read();
            let opponent_address = game.opponent.read();
            let caller = get_caller_address();

            assert!(
                game.stage.read() == Stages::CreatorCommitSolutionHash
                    || game.stage.read() == Stages::OpponentCommitSolutionHash,
                "Not in CommitSolutionHash stage",
            );

            game.solution_hashes.entry(caller).write(solution_hash);

            self
                .emit(
                    Event::CommitSolutionHash(
                        CommitSolutionHash { account: caller, solution_hash },
                    ),
                );

            if (game.solution_hashes.entry(creator_address).read() != 0)
                && (game.solution_hashes.entry(opponent_address).read() != 0) {
                game.stage.write(Stages::Playing);

                self.emit(Event::StageChange(StageChange { stage: Stages::Playing }));
            } else if game.solution_hashes.entry(creator_address).read() != 0 {
                game.stage.write(Stages::WaitingForOpponent);

                self.emit(Event::StageChange(StageChange { stage: Stages::WaitingForOpponent }));
            }
        }

        fn submit_guess(ref self: ContractState, game_id: u32, guess: Array<u8>) {
            let game = self.games.entry(game_id);
            let player_address = get_caller_address();

            assert!(game.stage.read() == Stages::Playing, "Not in Playing stage");
            assert!(guess.len() == 4, "Guess length must be 4");

            let submitted_guesses = game.submitted_guesses;
            let current_round = game.current_round.read();
            let player_submitted_guesses = submitted_guesses.entry(player_address);
            let player_current_round = player_submitted_guesses.len();

            assert!(player_current_round <= MAX_ROUND / 2, "Max round reached");

            let current_guess = Guess {
                g1: *guess.at(0),
                g2: *guess.at(1),
                g3: *guess.at(2),
                g4: *guess.at(3),
                submitted: true,
            };

            player_submitted_guesses.push(current_guess);
            game.current_round.write(current_round + 1);

            self
                .emit(
                    Event::SubmitGuess(
                        SubmitGuess { account: player_address, current_round, guess },
                    ),
                );
        }

        fn submit_hit_and_blow_proof(
            ref self: ContractState, game_id: u32, full_proof_with_hints: Span<felt252>,
        ) {
            let mut result = syscalls::library_call_syscall(
                VERIFIER_CLASSHASH.try_into().unwrap(),
                selector!("verify_ultra_starknet_honk_proof"),
                full_proof_with_hints,
            )
                .unwrap_syscall();
            // println!("Result: {:?}", result);
            let public_inputs = Serde::<Option<Span<u256>>>::deserialize(ref result)
                .unwrap()
                .expect('Proof is invalid');
            // println!("Public Inputs: {:?}", public_inputs);
            let _g1 = *public_inputs.at(0);
            let _g2 = *public_inputs.at(1);
            let _g3 = *public_inputs.at(2);
            let _g4 = *public_inputs.at(3);
            let solution_hash = *public_inputs.at(4);
            let num_hit = *public_inputs.at(5);
            let num_blow = *public_inputs.at(6);
            let game = self.games.entry(game_id);
            let player_address = get_caller_address();
            let hit: u8 = num_hit.try_into().unwrap();
            let blow: u8 = num_blow.try_into().unwrap();

            let submitted_hit_and_blow = game.submitted_hit_and_blow;
            let player_submitted_hit_and_blow = submitted_hit_and_blow.entry(get_caller_address());
            player_submitted_hit_and_blow.push(HitAndBlow { hit, blow, submitted: true });

            if hit == 4 && game.game_result.read() != GameResult::Win(game.opponent.read()) {
                assert!(
                    solution_hash == game.solution_hashes.entry(player_address).read(),
                    "Solution hash is not correct",
                );
                assert!(blow == 0, "Blow is not 0");

                game.game_result.write(GameResult::Win(player_address));
                game.stage.write(Stages::Reveal);

                self
                    .emit(
                        Event::GameFinish(
                            GameFinish { game_result: GameResult::Win(player_address) },
                        ),
                    );
            } else if self.get_game_current_round(game_id) == MAX_ROUND.try_into().unwrap() {
                game.game_result.write(GameResult::Tie);
                game.stage.write(Stages::Reveal);

                self.emit(Event::GameFinish(GameFinish { game_result: GameResult::Tie }));
            }

            self
                .emit(
                    Event::SubmitHitAndBlow(
                        SubmitHitAndBlow {
                            account: get_caller_address(),
                            current_round: self.get_game_current_round(game_id),
                            hit,
                            blow,
                        },
                    ),
                );
        }

        fn reveal_solution(ref self: ContractState, game_id: u32, solution: Array<u8>, salt: u256) {
            let game = self.games.entry(game_id);

            assert!(game.stage.read() == Stages::Reveal, "Not in Reveal stage");
            assert!(solution.len() == 4, "Solution length must be 4");

            let caller = get_caller_address();
            let solution_hash = game.solution_hashes.entry(caller).read();
            let mut hash_state = PoseidonTrait::new();
            hash_state = hash_state.update(salt.try_into().unwrap());

            for i in 1..=solution.len() {
                hash_state = hash_state.update((*solution.at(i)).into());
            }

            let computed_hash = hash_state.finalize();

            assert!(computed_hash == solution_hash.try_into().unwrap(), "Invalid solution");

            game.stage.write(Stages::Reveal);
            self.emit(Event::RevealSolution(RevealSolution { account: caller, solution }));

            if game.game_result.read() == GameResult::Win(caller) {
                self.emit(Event::GameFinish(GameFinish { game_result: GameResult::Win(caller) }))
            }
        }

        fn get_game_submitted_guesses(
            self: @ContractState, game_id: u32, player_address: ContractAddress,
        ) -> Array<Guess> {
            let game = self.games.entry(game_id);
            let mut submitted_guesses: Array<Guess> = ArrayTrait::new();

            for i in 0..game.submitted_guesses.entry(player_address).len() {
                let guess = game.submitted_guesses.entry(player_address).at(i);

                submitted_guesses.append(guess.read());
            }

            submitted_guesses
        }

        fn get_player_id(self: @ContractState, player_address: ContractAddress) -> u32 {
            self.players.entry(player_address).player_id.read()
        }

        fn get_player_name(self: @ContractState, player_address: ContractAddress) -> felt252 {
            self.players.entry(player_address).player_name.read()
        }

        fn get_game_creator_address(self: @ContractState, game_id: u32) -> ContractAddress {
            let game = self.games.entry(game_id);

            game.creator.read()
        }

        fn get_game_opponent_address(self: @ContractState, game_id: u32) -> ContractAddress {
            let game = self.games.entry(game_id);

            game.opponent.read()
        }

        fn get_game_submitted_hit_and_blow(
            self: @ContractState, game_id: u32, player_address: ContractAddress,
        ) -> Array<HitAndBlow> {
            let game = self.games.entry(game_id);
            let mut submitted_hit_and_blow: Array<HitAndBlow> = ArrayTrait::new();

            for i in 0..game.submitted_hit_and_blow.entry(player_address).len() {
                let hit_and_blow = game.submitted_hit_and_blow.entry(player_address).at(i);

                submitted_hit_and_blow
                    .append(
                        HitAndBlow {
                            hit: hit_and_blow.hit.read(),
                            blow: hit_and_blow.blow.read(),
                            submitted: hit_and_blow.submitted.read(),
                        },
                    );
            }

            submitted_hit_and_blow
        }

        fn get_game_result(self: @ContractState, game_id: u32) -> GameResult {
            let game = self.games.entry(game_id);

            game.game_result.read()
        }

        fn get_game_current_stage(self: @ContractState, game_id: u32) -> Stages {
            let game = self.games.entry(game_id);

            game.stage.read()
        }

        fn get_game_solution_hash(
            self: @ContractState, game_id: u32, player_address: ContractAddress,
        ) -> u256 {
            let game = self.games.entry(game_id);

            game.solution_hashes.entry(player_address).read()
        }

        fn get_game_current_round(self: @ContractState, game_id: u32) -> u8 {
            let game = self.games.entry(game_id);

            game.current_round.read()
        }

        fn get_total_players_count(self: @ContractState) -> u32 {
            self.total_players_count.read()
        }

        fn get_total_games_count(self: @ContractState) -> u32 {
            self.total_games_count.read()
        }

        fn get_player_active_game_ids(
            self: @ContractState, player_address: ContractAddress,
        ) -> Array<u32> {
            let mut player_game_ids: Array<u32> = ArrayTrait::new();
            let player = self.players.entry(player_address);

            for i in 0..player.player_game_ids.len() {
                let game_id = player.player_game_ids.at(i).read();

                let game_stage = self.get_game_current_stage(game_id);

                if game_stage == Stages::Playing {
                    player_game_ids.append(game_id);
                }
            }

            player_game_ids
        }

        fn get_available_game_ids(self: @ContractState) -> Array<u32> {
            let caller = get_caller_address();
            let total_games_count = self.get_total_games_count();
            let mut available_game_ids: Array<u32> = ArrayTrait::new();

            for i in 0..total_games_count {
                let game = self.games.entry(i);

                if game.stage.read() == Stages::WaitingForOpponent
                    && game.creator.read() != caller {
                    available_game_ids.append(i);
                }
            }

            available_game_ids
        }
    }
}
