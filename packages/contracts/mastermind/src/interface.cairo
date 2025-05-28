use mastermind::enums::{GameResult, Stages};
use mastermind::structs::{Guess, HitAndBlow};
use starknet::ContractAddress;

#[starknet::interface]
pub trait IMastermind<T> {
    fn init_game(ref self: T);

    fn register_player(ref self: T, player_name: felt252);

    fn join_game(ref self: T, game_id: u32);

    fn commit_solution_hash(ref self: T, game_id: u32, solution_hash: u256);

    fn submit_guess(ref self: T, game_id: u32, guess: Array<u8>);

    fn submit_hit_and_blow_proof(ref self: T, game_id: u32, full_proof_with_hints: Span<felt252>);

    fn reveal_solution(ref self: T, game_id: u32, solution: Array<u8>, salt: u256);

    fn get_player_id(self: @T, player_address: ContractAddress) -> u32;

    fn get_player_name(self: @T, player_address: ContractAddress) -> felt252;

    fn get_game_opponent_address(self: @T, game_id: u32) -> ContractAddress;

    fn get_game_creator_address(self: @T, game_id: u32) -> ContractAddress;

    fn get_game_submitted_guesses(
        self: @T, game_id: u32, player_address: ContractAddress,
    ) -> Array<Guess>;

    fn get_game_submitted_hit_and_blow(
        self: @T, game_id: u32, player_address: ContractAddress,
    ) -> Array<HitAndBlow>;

    fn get_game_result(self: @T, game_id: u32) -> GameResult;

    fn get_game_current_stage(self: @T, game_id: u32) -> Stages;

    fn get_game_solution_hash(self: @T, game_id: u32, player_address: ContractAddress) -> u256;

    fn get_game_current_round(self: @T, game_id: u32) -> u8;

    fn get_total_players_count(self: @T) -> u32;

    fn get_total_games_count(self: @T) -> u32;

    fn get_player_active_game_ids(self: @T, player_address: ContractAddress) -> Array<u32>;

    fn get_available_game_ids(self: @T) -> Array<u32>;

    fn get_player_total_games_won(self: @T, player_address: ContractAddress) -> u32;

    fn get_player_total_games_lost(self: @T, player_address: ContractAddress) -> u32;

    fn get_player_total_games_tied(self: @T, player_address: ContractAddress) -> u32;

    fn get_player_total_games_played(self: @T, player_address: ContractAddress) -> u32;
}
