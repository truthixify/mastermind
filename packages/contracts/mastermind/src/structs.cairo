use mastermind::enums::{GameResult, Stages};
use starknet::ContractAddress;
use starknet::storage::{Map, Vec};

#[derive(Debug, Copy, Drop, Default, PartialEq, Serde, starknet::Store)]
pub struct Guess {
    pub g1: u8,
    pub g2: u8,
    pub g3: u8,
    pub g4: u8,
    pub submitted: bool,
}

#[derive(Drop, PartialEq, Serde, starknet::Store)]
pub struct HitAndBlow {
    pub hit: u8,
    pub blow: u8,
    pub submitted: bool,
}

#[starknet::storage_node]
pub struct Game {
    pub game_id: u32,
    pub creator: ContractAddress,
    pub opponent: ContractAddress,
    pub submitted_guesses: Map<ContractAddress, Vec<Guess>>,
    pub submitted_hit_and_blow: Map<ContractAddress, Vec<HitAndBlow>>,
    pub solution_hashes: Map<ContractAddress, u256>,
    pub current_player: ContractAddress,
    pub stage: Stages,
    pub game_result: GameResult,
    pub current_round: u8,
}

#[starknet::storage_node]
pub struct Player {
    pub player_id: u32,
    pub player_name: felt252,
    pub player_game_ids: Vec<u32>,
    pub games_won: u32,
    pub games_lost: u32,
    pub games_tied: u32,
}
