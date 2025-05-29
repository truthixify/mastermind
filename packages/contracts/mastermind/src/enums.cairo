use starknet::ContractAddress; // StarkNet's address type, used in GameResult::Win.

/// Represents the possible outcomes of a Mastermind game.
/// This enum is used to track whether a game is ongoing, has been won by a player, or ended in a
/// tie.
///
/// # Variants
/// * `Undecided`: The default state for a game that is still in progress or has not yet started.
/// * `Win(ContractAddress)`: Indicates that the game has been won. The associated `ContractAddress`
/// is that of the winning player.
/// * `Tie`: Indicates that the game has ended in a tie, meaning no player successfully guessed the
/// opponent's code within the allowed rounds.
#[derive(Debug, Drop, PartialEq, Serde, Default, starknet::Store)]
pub enum GameResult {
    /// The game is ongoing, and no definitive result has been reached yet. This is the default
    /// state.
    #[default]
    Undecided,
    /// The game has been won. The `ContractAddress` stores the address of the winning player.
    Win: ContractAddress,
    /// The game has ended in a tie. Neither player won.
    Tie,
}

/// Represents the different stages a Mastermind game can be in throughout its lifecycle.
/// This enum helps manage game flow and ensures that actions are performed in the correct sequence.
///
/// # Variants
/// * `Init`: The initial state of a game, typically right after creation before any significant
/// player actions.
///           (Note: In the provided contract, games might directly start in
///           `CreatorCommitSolutionHash` or `WaitingForOpponent`
///           after `init_game`, so `Init` might be a conceptual default or an unused state in
///           practice).
/// * `CreatorCommitSolutionHash`: The stage where the game creator is expected to commit the hash
/// of their secret solution.
/// * `WaitingForOpponent`: The stage after the creator has committed their solution hash (or
/// initialized the game, depending on flow)
///                         and the game is waiting for an opponent to join and/or commit their
///                         solution hash.
/// * `OpponentCommitSolutionHash`: The stage where the opponent (who has joined the game) is
/// expected to commit the hash of their secret solution.
/// * `Playing`: The main gameplay stage where both players have committed their solution hashes,
/// and they are actively submitting guesses
///              and providing hit/blow feedback.
/// * `Reveal`: The final stage of the game, typically reached after a win or a tie. In this stage,
/// players can reveal their
///             actual solutions to be verified against their committed hashes.
#[derive(Debug, Drop, PartialEq, Serde, Default, starknet::Store)]
pub enum Stages {
    /// Default initial state. A game might not explicitly be in this state if it transitions
    /// immediately upon creation.
    #[default]
    Init,
    /// The game creator is expected to commit their solution hash.
    CreatorCommitSolutionHash,
    /// The game is awaiting an opponent to join (and potentially commit their solution hash).
    WaitingForOpponent,
    /// The opponent who has joined is expected to commit their solution hash.
    OpponentCommitSolutionHash,
    /// Active gameplay phase: players are submitting guesses and feedback.
    Playing,
    /// The game has concluded, and players can reveal their solutions for verification.
    Reveal,
}
