use starknet::ContractAddress;

#[derive(Debug, Drop, PartialEq, Serde, Default, starknet::Store)]
pub enum GameResult {
    #[default]
    Undecided,
    Win: ContractAddress,
    Tie,
}

#[derive(Debug, Drop, PartialEq, Serde, Default, starknet::Store)]
pub enum Stages {
    #[default]
    Init,
    CreatorCommitSolutionHash,
    WaitingForOpponent,
    OpponentCommitSolutionHash,
    Playing,
    Reveal,
}
