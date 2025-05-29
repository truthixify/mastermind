// Imports necessary enums and types for defining the structs.
use mastermind::enums::{GameResult, Stages}; // Custom enums for game state and results.
use starknet::ContractAddress; // StarkNet's address type.
use starknet::storage::{Map, Vec}; // Storage types for mapping and dynamic arrays.

/// Represents a single guess submitted by a player during a Mastermind game.
/// A guess consists of four characters.
///
/// # Fields
/// * `g1`: The first character of the guess (e.g., a color/digit).
/// * `g2`: The second character of the guess.
/// * `g3`: The third character of the guess.
/// * `g4`: The fourth character of the guess.
/// * `submitted`: A boolean flag indicating whether this guess has been formally recorded in the
/// game's state.
#[derive(Debug, Copy, Drop, Default, PartialEq, Serde, starknet::Store)]
pub struct Guess {
    /// The first character of the guess.
    pub g1: u8,
    /// The second character of the guess.
    pub g2: u8,
    /// The third character of the guess.
    pub g3: u8,
    /// The fourth character of the guess.
    pub g4: u8,
    /// Flag indicating if this guess has been officially submitted and recorded.
    pub submitted: bool,
}

/// Represents the feedback (hits and blows) given in response to a player's guess.
/// This is a core mechanic of Mastermind, indicating how close a guess was to the secret code.
///
/// # Fields
/// * `hit`: The number of characters in the guess that are correct in both value and position.
/// * `blow`: The number of characters in the guess that are correct in value but in the wrong
/// position.
/// * `submitted`: A boolean flag indicating whether this hit/blow feedback has been formally
/// submitted.
#[derive(Drop, PartialEq, Serde, starknet::Store)]
pub struct HitAndBlow {
    /// Number of correctly guessed characters in the correct position.
    pub hit: u8,
    /// Number of correctly guessed characters in the wrong position.
    pub blow: u8,
    /// Flag indicating if this feedback has been officially submitted.
    pub submitted: bool,
}

/// Represents the complete state and data for a single Mastermind game instance.
/// This struct is a storage node, meaning its instances are stored directly on the blockchain.
///
/// # Fields
/// * `game_id`: A unique identifier for this game instance.
/// * `creator`: The `ContractAddress` of the player who initiated the game.
/// * `opponent`: The `ContractAddress` of the player who joined the game as the opponent.
///              This can be a zero address if no opponent has joined yet.
/// * `submitted_guesses`: A map where keys are player addresses and values are `Vec<Guess>`,
///                        storing all guesses made by each player in this game.
/// * `submitted_hit_and_blow`: A map where keys are player addresses and values are
/// `Vec<HitAndBlow>`,
///                             storing all hit/blow feedback provided by each player for their
///                             opponent's guesses.
/// * `solution_hashes`: A map where keys are player addresses and values are `u256` solution
/// hashes.
///                      Each player commits a hash of their secret code (plus a salt) at the start.
/// * `current_player`: The `ContractAddress` of the player whose turn it is currently.
/// * `stage`: The current phase or stage of the game, as defined by the `Stages` enum (e.g.,
/// WaitingForOpponent, Playing, Reveal).
/// * `game_result`: The final outcome of the game, as defined by the `GameResult` enum (e.g., Win,
/// Tie, Undecided).
/// * `current_round`: An `u8` counter for the current round of the game.
#[starknet::storage_node]
pub struct Game {
    /// Unique identifier for the game.
    pub game_id: u32,
    /// Address of the game creator.
    pub creator: ContractAddress,
    /// Address of the joined opponent.
    pub opponent: ContractAddress,
    /// Mapping from a player's address to a vector of their submitted guesses.
    pub submitted_guesses: Map<ContractAddress, Vec<Guess>>,
    /// Mapping from a player's address to a vector of hit/blow feedback they provided.
    pub submitted_hit_and_blow: Map<ContractAddress, Vec<HitAndBlow>>,
    /// Mapping from a player's address to the hash of their secret solution.
    pub solution_hashes: Map<ContractAddress, u256>,
    /// Current stage of the game (e.g., `Stages::Playing`, `Stages::Reveal`).
    pub stage: Stages,
    /// The result of the game (e.g., `GameResult::Win(player_address)`, `GameResult::Tie`).
    pub game_result: GameResult,
    /// Current round number of the game. Increments with game progression.
    pub current_round: u8,
}

/// Represents a registered player in the Mastermind game system.
/// Stores player-specific information and statistics.
///
/// # Fields
/// * `player_id`: A unique `u32` identifier assigned to the player upon registration.
/// * `player_name`: The chosen display name of the player, stored as a `felt252`.
/// * `player_game_ids`: A `Vec<u32>` containing the IDs of all games the player has participated
/// in.
/// * `games_won`: The total number of games won by this player.
/// * `games_lost`: The total number of games lost by this player.
/// * `games_tied`: The total number of games that ended in a tie for this player.
#[starknet::storage_node]
pub struct Player {
    /// Unique internal ID assigned to the player.
    pub player_id: u32,
    /// Chosen display name of the player.
    pub player_name: felt252,
    /// List of all game IDs the player has participated in.
    pub player_game_ids: Vec<u32>,
    /// Total number of games won by the player.
    pub games_won: u32,
    /// Total number of games lost by the player.
    pub games_lost: u32,
    /// Total number of games played by the player that resulted in a tie.
    pub games_tied: u32,
}
