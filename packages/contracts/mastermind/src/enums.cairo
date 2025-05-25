use starknet::ContractAddress;

#[derive(Drop, PartialEq, Serde, starknet::Store)]
#[allow(starknet::store_no_default_variant)]
pub enum GameResult {
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
