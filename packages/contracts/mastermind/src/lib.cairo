// Main module for the Mastermind game contract.
// It's organized into submodules for enums, interfaces, and structs,
// and the main contract logic resides within the `Mastermind` module.
pub mod enums;
pub mod interface;
pub mod structs;

#[starknet::contract]
/// The main module for the Mastermind game contract.
/// This contract allows two players to play the classic code-breaking game Mastermind.
/// It manages player registration, game creation, turns, ZK proof verification for hit/blow counts,
/// and game state.
pub mod Mastermind {
    // Import necessary Cairo core libraries and StarkNet functionalities.
    use core::array::ArrayTrait; // For dynamic arrays.
    use core::circuit::u384; // For u384 arithmetic, used in hashing.
    use core::num::traits::Zero; // For checking if a value is zero.
    use garaga::hashes::poseidon_hash_2_bn254; // Poseidon hash function for cryptographic commitments.
    use mastermind::enums::{GameResult, Stages}; // Custom enums for game state and results.
    use mastermind::interface::IMastermind; // The external interface for this contract.
    use mastermind::structs::{
        Game, Guess, HitAndBlow, Player,
    }; // Custom data structures for game entities.
    use starknet::event::EventEmitter; // For emitting events.
    use starknet::storage::{ // For persistent storage.
        Map, MutableVecTrait, StoragePathEntry, StoragePointerReadAccess, StoragePointerWriteAccess,
        VecTrait,
    };
    use starknet::{
        ContractAddress, SyscallResultTrait, get_caller_address, syscalls,
    }; // StarkNet specific utilities.

    // Constants
    /// Maximum number of rounds allowed in a single game. A round consists of one guess from each
    /// player.
    /// So, each player gets MAX_ROUND / 2 guesses.
    pub const MAX_ROUND: u64 = 10;
    /// Class hash of the ZK verifier contract used to verify hit/blow proofs.
    /// This contract is called to ensure that the reported hits and blows are correct
    /// without revealing the secret code.
    pub const VERIFIER_CLASSHASH: felt252 =
        0x01a9aa9d61d25fe04260e5e6b9ec7bdbed753a31c99f8cd47e39d6a528bb820b;

    /// Defines the contract's persistent storage structure.
    #[storage]
    pub struct Storage {
        /// Maps game IDs (u32) to `Game` structs, storing details of each game.
        pub games: Map<u32, Game>,
        /// Maps player `ContractAddress` to `Player` structs, storing player-specific data.
        pub players: Map<ContractAddress, Player>,
        /// Counter for the total number of games created. Used for assigning new game IDs.
        pub total_games_count: u32,
        /// Counter for the total number of registered players. Used for assigning new player IDs.
        pub total_players_count: u32,
    }

    /// Defines the events that can be emitted by this contract.
    /// Events are used to log significant actions and state changes on the blockchain,
    /// making it easier for off-chain applications to track game progress.
    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event {
        /// Emitted when a new game is initialized.
        InitializeGame: InitializeGame,
        /// Emitted when a new player registers.
        RegisterPlayer: RegisterPlayer,
        /// Emitted when a player commits the hash of their secret solution.
        CommitSolutionHash: CommitSolutionHash,
        /// Emitted when a player submits a guess.
        SubmitGuess: SubmitGuess,
        /// Emitted when a player submits hit and blow counts (after ZK proof verification).
        SubmitHitAndBlow: SubmitHitAndBlow,
        /// Emitted when a player reveals their secret solution at the end of the game.
        RevealSolution: RevealSolution,
        /// Emitted when a game finishes (win, loss, or tie).
        GameFinish: GameFinish,
        /// Emitted when the game stage changes.
        StageChange: StageChange,
        /// Emitted when an opponent joins a game.
        OpponentJoined: OpponentJoined,
    }

    // --- Event Struct Definitions ---

    /// Event data for when a new game is initialized.
    #[derive(Drop, starknet::Event)]
    pub struct InitializeGame {
        /// The address of the player who initialized the game (game creator).
        #[key] // Indexed field for easier off-chain querying.
        pub account: ContractAddress,
        /// The unique ID of the newly initialized game.
        pub game_id: u32,
    }

    /// Event data for when a new player registers.
    #[derive(Drop, starknet::Event)]
    pub struct RegisterPlayer {
        /// The address of the registered player.
        #[key]
        pub account: ContractAddress,
        /// The unique ID assigned to the player.
        pub player_id: u32,
    }

    /// Event data for when a player commits the hash of their secret solution.
    #[derive(Drop, starknet::Event)]
    pub struct CommitSolutionHash {
        /// The address of the player committing the hash.
        #[key]
        pub account: ContractAddress,
        /// The committed hash of the solution (typically Poseidon(solution_packed, salt)).
        pub solution_hash: u256,
    }

    /// Event data for when a player submits a guess.
    #[derive(Drop, starknet::Event)]
    pub struct SubmitGuess {
        /// The address of the player submitting the guess.
        #[key]
        pub account: ContractAddress,
        /// The current round number within the game when this guess was submitted for this player.
        pub current_round: u8,
        /// The submitted guess (an array of 4 numbers, typically 0-7).
        pub guess: Array<u8>,
    }

    /// Event data for when a player submits hit and blow counts for their opponent's guess.
    /// This event is emitted after successful ZK proof verification.
    #[derive(Drop, starknet::Event)]
    pub struct SubmitHitAndBlow {
        /// The address of the player providing the feedback (hits/blows) for their opponent's
        /// guess.
        #[key]
        pub account: ContractAddress,
        /// The round number corresponding to this feedback.
        pub current_round: u8,
        /// The number of "hits" (correct number in correct position).
        pub hit: u8,
        /// The number of "blows" (correct number in wrong position).
        pub blow: u8,
    }

    /// Event data for when a player reveals their secret solution.
    /// This usually happens at the end of the game or if a player wins and needs to prove their
    /// solution.
    #[derive(Drop, starknet::Event)]
    pub struct RevealSolution {
        /// The address of the player revealing their solution.
        #[key]
        pub account: ContractAddress,
        /// The ID of the game for which the solution is revealed.
        #[key]
        pub game_id: u32,
        /// The actual secret solution (an array of 4 numbers).
        pub solution: Array<u8>,
    }

    /// Event data for when a game finishes.
    #[derive(Drop, starknet::Event)]
    pub struct GameFinish {
        /// The ID of the finished game.
        #[key]
        pub game_id: u32,
        /// The outcome of the game (e.g., Win(winner_address), Tie, Undecided).
        pub game_result: GameResult,
    }

    /// Event data for when the game's current stage changes.
    #[derive(Drop, starknet::Event)]
    pub struct StageChange {
        /// The new stage of the game (e.g., Playing, Reveal).
        pub stage: Stages,
    }

    /// Event data for when an opponent joins a game.
    #[derive(Drop, starknet::Event)]
    pub struct OpponentJoined {
        /// The address of the opponent who joined the game.
        #[key]
        pub account: ContractAddress,
        /// The ID of the game joined by the opponent.
        pub game_id: u32,
    }

    /// Contract constructor.
    /// Called once when the contract is deployed.
    /// This constructor is empty, meaning no specific initialization logic is performed at
    /// deployment time beyond setting up the storage.
    #[constructor]
    pub fn constructor(ref self: ContractState) {}

    /// Implementation of the `IMastermind` interface, containing the contract's core logic
    /// for the Mastermind game.
    #[abi(embed_v0)]
    impl MasterMindImpl of IMastermind<ContractState> {
        /// Registers a new player in the Mastermind game system.
        /// A player must be registered before they can create or join games.
        /// Each player is assigned a unique player ID.
        ///
        /// # Arguments
        /// * `ref self`: A mutable reference to the contract's state.
        /// * `player_name`: A `felt252` representing the desired display name for the player.
        ///
        /// # Panics
        /// * If the `get_caller_address()` is already registered (i.e., `player.player_id` is not
        /// its default zero value).
        ///
        /// # Emits
        /// * `Event::RegisterPlayer` on successful registration.
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

        /// Initializes a new game instance.
        /// The caller of this function becomes the creator of the game.
        /// The game is assigned a new unique ID and set to the `CreatorCommitSolutionHash` stage.
        ///
        /// # Arguments
        /// * `ref self`: A mutable reference to the contract's state.
        ///
        /// # Panics
        /// * If the caller (`get_caller_address()`) is not registered as a player.
        ///
        /// # Emits
        /// * `Event::InitializeGame` on successful game initialization.
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

        /// Allows a registered player to join an existing game that is waiting for an opponent.
        /// The caller becomes the opponent in the specified game.
        ///
        /// # Arguments
        /// * `ref self`: A mutable reference to the contract's state.
        /// * `game_id`: The `u32` ID of the game to join.
        ///
        /// # Panics
        /// * If the caller (`get_caller_address()`) is not registered as a player.
        /// * If the caller is the creator of the game (`game.creator.read() == opponent_address`).
        /// * If an opponent has already joined the game (`!game.opponent.read().is_zero()`).
        /// * If the game is not in the `Stages::WaitingForOpponent` stage (implicitly, as the stage
        /// is only updated if this condition is met).
        ///
        /// # Emits
        /// * `Event::OpponentJoined` if the player successfully joins the game.
        fn join_game(ref self: ContractState, game_id: u32) {
            let game = self.games.entry(game_id);
            let opponent_address = get_caller_address();
            let player_id = self.players.entry(opponent_address).player_id.read();
            let player = self.players.entry(opponent_address);
            let total_players_count = self.total_players_count.read();

            assert!(
                player_id >= 0 && total_players_count > 0,
                "You need to register first before you can join a game",
            );
            assert!(game.creator.read() != opponent_address, "You cannot join your own game");
            assert!(game.opponent.read().is_zero(), "Opponent already joined");

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

        /// Allows a player (creator or opponent) to commit the hash of their secret solution for a
        /// game.
        /// This must be done before the guessing phase (`Stages::Playing`) begins.
        ///
        /// # Arguments
        /// * `ref self`: A mutable reference to the contract's state.
        /// * `game_id`: The `u32` ID of the game.
        /// * `solution_hash`: A `u256` representing the hash of the player's secret code and a
        /// salt.
        ///
        /// # Panics
        /// * If the game is not in the `Stages::CreatorCommitSolutionHash` or
        /// `Stages::OpponentCommitSolutionHash` stage.
        ///
        /// # Emits
        /// * `Event::CommitSolutionHash` for the committing player.
        /// * `Event::StageChange` to `Stages::WaitingForOpponent` if the creator commits and no
        /// opponent has committed yet.
        /// * `Event::StageChange` to `Stages::Playing` if both players have committed their
        /// solution hashes.
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

        /// Allows a player to submit their guess for the opponent's secret code.
        ///
        /// # Arguments
        /// * `ref self`: A mutable reference to the contract's state.
        /// * `game_id`: The `u32` ID of the game.
        /// * `guess`: An `Array<u8>` of length 4 representing the player's guess. Each element is a
        /// digit.
        ///
        /// # Panics
        /// * If the game is not in the `Stages::Playing` stage.
        /// * If the `guess` array length is not equal to 4.
        /// * If the player has already submitted `MAX_ROUND / 2` guesses.
        ///
        /// # Emits
        /// * `Event::SubmitGuess` on successful guess submission.
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
            game.current_round.write(current_round + 1); // Increments total guesses in game

            self
                .emit(
                    Event::SubmitGuess(
                        SubmitGuess { account: player_address, current_round, guess },
                    ),
                );
        }

        /// Submits a Zero-Knowledge Proof to verify the hit and blow counts for an opponent's
        /// guess.
        /// The caller is the player whose code was guessed, and they are providing feedback.
        /// The proof is verified by an external verifier contract specified by
        /// `VERIFIER_CLASSHASH`.
        ///
        /// # Arguments
        /// * `ref self`: A mutable reference to the contract's state.
        /// * `game_id`: The `u32` ID of the game.
        /// * `full_proof_with_hints`: A `Span<felt252>` containing the ZK proof data and public
        /// inputs.
        ///
        /// # Panics
        /// * If the ZK proof verification fails (e.g., `library_call_syscall` returns an error or
        /// deserialization fails).
        /// * If the game ends in a win (`hit == 4`) but the `solution_hash` from the proof's public
        /// inputs
        ///   does not match the caller's committed `solution_hash`.
        /// * If `hit == 4` but `blow != 0`.
        ///
        /// # Emits
        /// * `Event::SubmitHitAndBlow` on successful proof verification and feedback submission.
        /// * `Event::GameFinish` if the submission results in a win or a tie.
        fn submit_hit_and_blow_proof(
            ref self: ContractState, game_id: u32, full_proof_with_hints: Span<felt252>,
        ) {
            let mut result = syscalls::library_call_syscall(
                VERIFIER_CLASSHASH.try_into().unwrap(),
                selector!("verify_ultra_starknet_honk_proof"),
                full_proof_with_hints,
            )
                .unwrap_syscall();
            let public_inputs = Serde::<Option<Span<u256>>>::deserialize(ref result)
                .unwrap()
                .expect('Proof is invalid');
            let solution_hash = *public_inputs.at(4);
            let num_hit = *public_inputs.at(5);
            let num_blow = *public_inputs.at(6);
            let game = self.games.entry(game_id);
            let player_address =
                get_caller_address(); // Player whose code was guessed, providing feedback
            let hit: u8 = num_hit.try_into().unwrap();
            let blow: u8 = num_blow.try_into().unwrap();
            let submitted_hit_and_blow = game.submitted_hit_and_blow;
            let player_submitted_hit_and_blow = submitted_hit_and_blow.entry(player_address);
            player_submitted_hit_and_blow.push(HitAndBlow { hit, blow, submitted: true });

            // Determine the opponent (the one who made the guess and might have won)
            let opponent_address = if player_address == game.creator.read() {
                game.opponent.read()
            } else {
                game.creator.read()
            };
            let player = self
                .players
                .entry(player_address); // The one whose code was guessed (potential loser)
            let opponent = self
                .players
                .entry(opponent_address); // The one who guessed (potential winner)

            if hit == 4 && game.game_result.read() == GameResult::Undecided {
                assert!(
                    solution_hash == game.solution_hashes.entry(player_address).read(),
                    "Solution hash is not correct",
                );
                assert!(blow == 0, "Blow is not 0");

                game.game_result.write(GameResult::Win(opponent_address));
                game.stage.write(Stages::Reveal);
                opponent.games_won.write(player.games_won.read() + 1);
                player.games_lost.write(opponent.games_lost.read() + 1);

                self
                    .emit(
                        Event::GameFinish(
                            GameFinish { game_id, game_result: GameResult::Win(opponent_address) },
                        ),
                    );
            } else if self.get_game_current_round(game_id) > MAX_ROUND.try_into().unwrap()
                && game.game_result.read() == GameResult::Undecided { // Check if max rounds reached
                game.game_result.write(GameResult::Tie);
                game.stage.write(Stages::Reveal);

                // Update tie stats for both players involved
                player.games_tied.write(player.games_tied.read() + 1);
                opponent.games_tied.write(opponent.games_tied.read() + 1);

                self.emit(Event::GameFinish(GameFinish { game_id, game_result: GameResult::Tie }));
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

        /// Allows a player to reveal their secret solution for a game, typically after the game has
        /// concluded.
        /// The revealed solution is verified against the hash committed at the beginning of the
        /// game.
        ///
        /// # Arguments
        /// * `ref self`: A mutable reference to the contract's state.
        /// * `game_id`: The `u32` ID of the game.
        /// * `solution`: An `Array<u8>` of length 4 representing the player's secret solution.
        /// * `salt`: The `u256` salt value used with the solution to generate the committed hash.
        ///
        /// # Panics
        /// * If the game is not in the `Stages::Reveal` stage.
        /// * If the `solution` array length is not equal to 4.
        /// * If the Poseidon hash of the provided `solution` (packed) and `salt` does not match
        ///   the `solution_hash` committed by the caller for this game.
        ///
        /// # Emits
        /// * `Event::RevealSolution` on successful solution reveal and verification.
        fn reveal_solution(ref self: ContractState, game_id: u32, solution: Array<u8>, salt: u256) {
            let game = self.games.entry(game_id);

            assert!(game.stage.read() == Stages::Reveal, "Not in Reveal stage");
            assert!(solution.len() == 4, "Solution length must be 4");

            let caller = get_caller_address();
            let solution_hash = game.solution_hashes.entry(caller).read();
            let s0_u256: u256 = (*solution.at(0)).into();
            let s1_u256: u256 = (*solution.at(1)).into();
            let s2_u256: u256 = (*solution.at(2)).into();
            let s3_u256: u256 = (*solution.at(3)).into();
            // Pack solution into a u384 for hashing: s0 + s1*256 + s2*256^2 + s3*256^3
            let prep_solution: u384 = (s0_u256
                + s1_u256 * 256
                + s2_u256 * 256 * 256
                + s3_u256 * 256 * 256 * 256)
                .into();
            let salt_u384: u384 = salt.into();
            let computed_hash = poseidon_hash_2_bn254(prep_solution, salt_u384);

            assert!(computed_hash == solution_hash.into(), "Invalid solution");

            self.emit(Event::RevealSolution(RevealSolution { account: caller, game_id, solution }));
        }

        // --- Getter Functions ---

        /// Retrieves all submitted guesses for a specific player in a given game.
        ///
        /// # Arguments
        /// * `self`: A snapshot of the contract's state.
        /// * `game_id`: The `u32` ID of the game.
        /// * `player_address`: The `ContractAddress` of the player whose guesses are requested.
        ///
        /// # Returns
        /// An `Array<Guess>` containing all guesses submitted by the specified player in the game.
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

        /// Retrieves the unique ID of a registered player.
        ///
        /// # Arguments
        /// * `self`: A snapshot of the contract's state.
        /// * `player_address`: The `ContractAddress` of the player.
        ///
        /// # Returns
        /// The `u32` player ID. Returns 0 if the player is not registered or if 0 was the first
        /// assigned ID.
        fn get_player_id(self: @ContractState, player_address: ContractAddress) -> u32 {
            self.players.entry(player_address).player_id.read()
        }

        /// Retrieves the name of a registered player.
        ///
        /// # Arguments
        /// * `self`: A snapshot of the contract's state.
        /// * `player_address`: The `ContractAddress` of the player.
        ///
        /// # Returns
        /// The `felt252` player name.
        fn get_player_name(self: @ContractState, player_address: ContractAddress) -> felt252 {
            self.players.entry(player_address).player_name.read()
        }

        /// Retrieves the `ContractAddress` of the creator of a specific game.
        ///
        /// # Arguments
        /// * `self`: A snapshot of the contract's state.
        /// * `game_id`: The `u32` ID of the game.
        ///
        /// # Returns
        /// The `ContractAddress` of the game creator.
        fn get_game_creator_address(self: @ContractState, game_id: u32) -> ContractAddress {
            let game = self.games.entry(game_id);

            game.creator.read()
        }

        /// Retrieves the `ContractAddress` of the opponent in a specific game.
        ///
        /// # Arguments
        /// * `self`: A snapshot of the contract's state.
        /// * `game_id`: The `u32` ID of the game.
        ///
        /// # Returns
        /// The `ContractAddress` of the opponent. Returns a zero address if no opponent has joined.
        fn get_game_opponent_address(self: @ContractState, game_id: u32) -> ContractAddress {
            let game = self.games.entry(game_id);

            game.opponent.read()
        }

        /// Retrieves all submitted hit and blow feedback by a specific player for their opponent's
        /// guesses in a given game.
        ///
        /// # Arguments
        /// * `self`: A snapshot of the contract's state.
        /// * `game_id`: The `u32` ID of the game.
        /// * `player_address`: The `ContractAddress` of the player who submitted the hit/blow
        /// feedback.
        ///
        /// # Returns
        /// An `Array<HitAndBlow>` containing the hit and blow records submitted by the player.
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

        /// Retrieves the result of a specific game.
        ///
        /// # Arguments
        /// * `self`: A snapshot of the contract's state.
        /// * `game_id`: The `u32` ID of the game.
        ///
        /// # Returns
        /// The `GameResult` enum indicating the game's outcome (e.g., Win, Tie, Undecided).
        fn get_game_result(self: @ContractState, game_id: u32) -> GameResult {
            let game = self.games.entry(game_id);

            game.game_result.read()
        }

        /// Retrieves the current stage of a specific game.
        ///
        /// # Arguments
        /// * `self`: A snapshot of the contract's state.
        /// * `game_id`: The `u32` ID of the game.
        ///
        /// # Returns
        /// The `Stages` enum representing the current stage of the game.
        fn get_game_current_stage(self: @ContractState, game_id: u32) -> Stages {
            let game = self.games.entry(game_id);

            game.stage.read()
        }

        /// Retrieves the committed solution hash for a specific player in a given game.
        ///
        /// # Arguments
        /// * `self`: A snapshot of the contract's state.
        /// * `game_id`: The `u32` ID of the game.
        /// * `player_address`: The `ContractAddress` of the player.
        ///
        /// # Returns
        /// The `u256` solution hash. Returns 0 if no hash has been committed by this player for
        /// this game.
        fn get_game_solution_hash(
            self: @ContractState, game_id: u32, player_address: ContractAddress,
        ) -> u256 {
            let game = self.games.entry(game_id);

            game.solution_hashes.entry(player_address).read()
        }

        /// Retrieves the current round number for a specific game.
        /// This typically represents the total number of guesses made by both players combined up
        /// to this point.
        ///
        /// # Arguments
        /// * `self`: A snapshot of the contract's state.
        /// * `game_id`: The `u32` ID of the game.
        ///
        /// # Returns
        /// The current round number as `u8`.
        fn get_game_current_round(self: @ContractState, game_id: u32) -> u8 {
            let game = self.games.entry(game_id);

            game.current_round.read()
        }

        /// Retrieves the total number of registered players in the system.
        ///
        /// # Arguments
        /// * `self`: A snapshot of the contract's state.
        ///
        /// # Returns
        /// The total player count as `u32`.
        fn get_total_players_count(self: @ContractState) -> u32 {
            self.total_players_count.read()
        }

        /// Retrieves the total number of games created in the system.
        ///
        /// # Arguments
        /// * `self`: A snapshot of the contract's state.
        ///
        /// # Returns
        /// The total game count as `u32`.
        fn get_total_games_count(self: @ContractState) -> u32 {
            self.total_games_count.read()
        }

        /// Retrieves a list of game IDs where the specified player is currently active
        /// (i.e., the game is in the `Stages::Playing` stage).
        ///
        /// # Arguments
        /// * `self`: A snapshot of the contract's state.
        /// * `player_address`: The `ContractAddress` of the player.
        ///
        /// # Returns
        /// An `Array<u32>` of game IDs where the player is actively playing.
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

        /// Retrieves a list of game IDs that are currently available for joining.
        /// An available game is one that is in the `Stages::WaitingForOpponent` stage
        /// and was not created by the caller.
        ///
        /// # Arguments
        /// * `self`: A snapshot of the contract's state.
        ///
        /// # Returns
        /// An `Array<u32>` of available game IDs.
        fn get_available_game_ids(self: @ContractState) -> Array<u32> {
            let caller = get_caller_address();
            let total_games_count = self.get_total_games_count();
            let mut available_game_ids: Array<u32> = ArrayTrait::new();

            for i in 0..total_games_count {
                let game = self.games.entry(i); // i is the game_id

                if game.stage.read() == Stages::WaitingForOpponent
                    && game.creator.read() != caller {
                    available_game_ids.append(i);
                }
            }

            available_game_ids
        }

        /// Retrieves the total number of games won by a specific player.
        ///
        /// # Arguments
        /// * `self`: A snapshot of the contract's state.
        /// * `player_address`: The `ContractAddress` of the player.
        ///
        /// # Returns
        /// The total number of games won by the player as `u32`.
        fn get_player_total_games_won(
            self: @ContractState, player_address: ContractAddress,
        ) -> u32 {
            self.players.entry(player_address).games_won.read()
        }

        /// Retrieves the total number of games lost by a specific player.
        ///
        /// # Arguments
        /// * `self`: A snapshot of the contract's state.
        /// * `player_address`: The `ContractAddress` of the player.
        ///
        /// # Returns
        /// The total number of games lost by the player as `u32`.
        fn get_player_total_games_lost(
            self: @ContractState, player_address: ContractAddress,
        ) -> u32 {
            self.players.entry(player_address).games_lost.read()
        }

        /// Retrieves the total number of games tied by a specific player.
        ///
        /// # Arguments
        /// * `self`: A snapshot of the contract's state.
        /// * `player_address`: The `ContractAddress` of the player.
        ///
        /// # Returns
        /// The total number of games tied by the player as `u32`.
        fn get_player_total_games_tied(
            self: @ContractState, player_address: ContractAddress,
        ) -> u32 {
            self.players.entry(player_address).games_tied.read()
        }

        /// Retrieves the total number of games played (won + lost + tied) by a specific player.
        ///
        /// # Arguments
        /// * `self`: A snapshot of the contract's state.
        /// * `player_address`: The `ContractAddress` of the player.
        ///
        /// # Returns
        /// The total number of games played by the player as `u32`.
        fn get_player_total_games_played(
            self: @ContractState, player_address: ContractAddress,
        ) -> u32 {
            let player = self.players.entry(player_address);

            player.games_won.read() + player.games_lost.read() + player.games_tied.read()
        }
    }
}
