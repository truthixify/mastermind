// range proof function to check a <= x <= b
pub fn range_proof(a: u8, x: u8, b: u8) -> bool {
    x >= a & x <= b
}