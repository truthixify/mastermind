// Imports necessary enums, structs, and types for the interface definition.
use mastermind::enums::{GameResult, Stages}; // Custom enums for game state and results.
use mastermind::structs::{Guess, HitAndBlow}; // Custom structs for game data.
use starknet::ContractAddress; // StarkNet's address type.

/// Defines the external interface for the Mastermind game contract.
/// This trait outlines all the functions that can be called on the contract,
/// both by players interacting with the game and by off-chain systems querying game state.
///
/// The `T` generic parameter represents the contract's state type.
#[starknet::interface]
pub trait IMastermind<T> {
    /// Initializes a new game instance.
    /// The caller becomes the creator of the game.
    ///
    /// # Arguments
    /// * `ref self`: A mutable reference to the contract's state.
    fn init_game(ref self: T);

    /// Registers a new player in the Mastermind game system.
    ///
    /// # Arguments
    /// * `ref self`: A mutable reference to the contract's state.
    /// * `player_name`: The chosen display name for the player, as a `felt252`.
    fn register_player(ref self: T, player_name: felt252);

    /// Allows a registered player to join an existing game that is waiting for an opponent.
    ///
    /// # Arguments
    /// * `ref self`: A mutable reference to the contract's state.
    /// * `game_id`: The `u32` ID of the game to join.
    fn join_game(ref self: T, game_id: u32);

    /// Allows a player (creator or opponent) to commit the hash of their secret solution for a
    /// game.
    /// This must be done before the guessing phase begins.
    ///
    /// # Arguments
    /// * `ref self`: A mutable reference to the contract's state.
    /// * `game_id`: The `u32` ID of the game.
    /// * `solution_hash`: A `u256` representing the hash of the player's secret code and a salt.
    fn commit_solution_hash(ref self: T, game_id: u32, solution_hash: u256);

    /// Allows a player to submit their guess for the opponent's secret code in a specific game.
    ///
    /// # Arguments
    /// * `ref self`: A mutable reference to the contract's state.
    /// * `game_id`: The `u32` ID of the game.
    /// * `guess`: An `Array<u8>` of length 4 representing the player's guess.
    fn submit_guess(ref self: T, game_id: u32, guess: Array<u8>);

    /// Submits a Zero-Knowledge Proof to verify the hit and blow counts for an opponent's guess.
    /// The ZK proof ensures the feedback is honest without revealing the secret code.
    ///
    /// # Arguments
    /// * `ref self`: A mutable reference to the contract's state.
    /// * `game_id`: The `u32` ID of the game.
    /// * `full_proof_with_hints`: A `Span<felt252>` containing the encoded ZK proof data and public
    /// inputs (which include hits/blows).
    fn submit_hit_and_blow_proof(ref self: T, game_id: u32, full_proof_with_hints: Span<felt252>);

    /// Allows a player to reveal their secret solution after a game has concluded or if they won.
    /// The revealed solution is verified against the previously committed hash.
    ///
    /// # Arguments
    /// * `ref self`: A mutable reference to the contract's state.
    /// * `game_id`: The `u32` ID of the game.
    /// * `solution`: An `Array<u8>` of length 4 representing the player's secret solution.
    /// * `salt`: The `u256` salt value used with the solution to generate the committed hash.
    fn reveal_solution(ref self: T, game_id: u32, solution: Array<u8>, salt: u256);

    /// Retrieves the unique `u32` ID of a registered player.
    ///
    /// # Arguments
    /// * `self`: A snapshot of the contract's state.
    /// * `player_address`: The `ContractAddress` of the player.
    /// # Returns
    /// The player's `u32` ID.
    fn get_player_id(self: @T, player_address: ContractAddress) -> u32;

    /// Retrieves the `felt252` name of a registered player.
    ///
    /// # Arguments
    /// * `self`: A snapshot of the contract's state.
    /// * `player_address`: The `ContractAddress` of the player.
    /// # Returns
    /// The player's name.
    fn get_player_name(self: @T, player_address: ContractAddress) -> felt252;

    /// Retrieves the `ContractAddress` of the opponent in a specific game.
    ///
    /// # Arguments
    /// * `self`: A snapshot of the contract's state.
    /// * `game_id`: The `u32` ID of the game.
    /// # Returns
    /// The opponent's `ContractAddress`. Returns a zero address if no opponent.
    fn get_game_opponent_address(self: @T, game_id: u32) -> ContractAddress;

    /// Retrieves the `ContractAddress` of the creator of a specific game.
    ///
    /// # Arguments
    /// * `self`: A snapshot of the contract's state.
    /// * `game_id`: The `u32` ID of the game.
    /// # Returns
    /// The game creator's `ContractAddress`.
    fn get_game_creator_address(self: @T, game_id: u32) -> ContractAddress;

    /// Retrieves all submitted guesses for a specific player in a given game.
    ///
    /// # Arguments
    /// * `self`: A snapshot of the contract's state.
    /// * `game_id`: The `u32` ID of the game.
    /// * `player_address`: The `ContractAddress` of the player whose guesses are requested.
    /// # Returns
    /// An `Array<Guess>` containing the player's guesses.
    fn get_game_submitted_guesses(
        self: @T, game_id: u32, player_address: ContractAddress,
    ) -> Array<Guess>;

    /// Retrieves all submitted hit and blow feedback by a specific player in a given game.
    ///
    /// # Arguments
    /// * `self`: A snapshot of the contract's state.
    /// * `game_id`: The `u32` ID of the game.
    /// * `player_address`: The `ContractAddress` of the player who submitted the feedback.
    /// # Returns
    /// An `Array<HitAndBlow>` containing the hit/blow records.
    fn get_game_submitted_hit_and_blow(
        self: @T, game_id: u32, player_address: ContractAddress,
    ) -> Array<HitAndBlow>;

    /// Retrieves the result (Win, Tie, Undecided) of a specific game.
    ///
    /// # Arguments
    /// * `self`: A snapshot of the contract's state.
    /// * `game_id`: The `u32` ID of the game.
    /// # Returns
    /// The `GameResult` enum.
    fn get_game_result(self: @T, game_id: u32) -> GameResult;

    /// Retrieves the current stage (e.g., Playing, Reveal) of a specific game.
    ///
    /// # Arguments
    /// * `self`: A snapshot of the contract's state.
    /// * `game_id`: The `u32` ID of the game.
    /// # Returns
    /// The `Stages` enum.
    fn get_game_current_stage(self: @T, game_id: u32) -> Stages;

    /// Retrieves the committed solution hash for a specific player in a given game.
    ///
    /// # Arguments
    /// * `self`: A snapshot of the contract's state.
    /// * `game_id`: The `u32` ID of the game.
    /// * `player_address`: The `ContractAddress` of the player.
    /// # Returns
    /// The `u256` solution hash.
    fn get_game_solution_hash(self: @T, game_id: u32, player_address: ContractAddress) -> u256;

    /// Retrieves the current round number for a specific game.
    ///
    /// # Arguments
    /// * `self`: A snapshot of the contract's state.
    /// * `game_id`: The `u32` ID of the game.
    /// # Returns
    /// The current round number as `u8`.
    fn get_game_current_round(self: @T, game_id: u32) -> u8;

    /// Retrieves the total number of registered players in the system.
    ///
    /// # Arguments
    /// * `self`: A snapshot of the contract's state.
    /// # Returns
    /// Total player count as `u32`.
    fn get_total_players_count(self: @T) -> u32;

    /// Retrieves the total number of games created in the system.
    ///
    /// # Arguments
    /// * `self`: A snapshot of the contract's state.
    /// # Returns
    /// Total game count as `u32`.
    fn get_total_games_count(self: @T) -> u32;

    /// Retrieves a list of game IDs where the specified player is currently active (game is in
    /// `Playing` stage).
    ///
    /// # Arguments
    /// * `self`: A snapshot of the contract's state.
    /// * `player_address`: The `ContractAddress` of the player.
    /// # Returns
    /// An `Array<u32>` of active game IDs.
    fn get_player_active_game_ids(self: @T, player_address: ContractAddress) -> Array<u32>;

    /// Retrieves a list of game IDs that are currently waiting for an opponent and were not created
    /// by the caller.
    ///
    /// # Arguments
    /// * `self`: A snapshot of the contract's state.
    /// # Returns
    /// An `Array<u32>` of available game IDs.
    fn get_available_game_ids(self: @T) -> Array<u32>;

    /// Retrieves the total number of games won by a specific player.
    ///
    /// # Arguments
    /// * `self`: A snapshot of the contract's state.
    /// * `player_address`: The `ContractAddress` of the player.
    /// # Returns
    /// Total games won as `u32`.
    fn get_player_total_games_won(self: @T, player_address: ContractAddress) -> u32;

    /// Retrieves the total number of games lost by a specific player.
    ///
    /// # Arguments
    /// * `self`: A snapshot of the contract's state.
    /// * `player_address`: The `ContractAddress` of the player.
    /// # Returns
    /// Total games lost as `u32`.
    fn get_player_total_games_lost(self: @T, player_address: ContractAddress) -> u32;

    /// Retrieves the total number of games tied by a specific player.
    ///
    /// # Arguments
    /// * `self`: A snapshot of the contract's state.
    /// * `player_address`: The `ContractAddress` of the player.
    /// # Returns
    /// Total games tied as `u32`.
    fn get_player_total_games_tied(self: @T, player_address: ContractAddress) -> u32;

    /// Retrieves the total number of games played (won + lost + tied) by a specific player.
    ///
    /// # Arguments
    /// * `self`: A snapshot of the contract's state.
    /// * `player_address`: The `ContractAddress` of the player.
    /// # Returns
    /// Total games played as `u32`.
    fn get_player_total_games_played(self: @T, player_address: ContractAddress) -> u32;
}
