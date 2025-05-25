mod range_proof;

use range_proof::range_proof;
use std;

fn main(
  guess: pub [u8; 4],
  solution: [u8; 4],
  salt: Field,
  solution_hash: pub Field,
  num_hit: pub u8,
  num_blow: pub u8,
) -> pub Field {
    // Minimum ascii character allowed
    let min_ascii_char = 65;
    // Maximum ascii character allowed
    let max_ascii_char = 90;

    // Assert that the guess and solution char are all between 65 and 90.
    for i in 0..4 {
        assert(range_proof(min_ascii_char, guess[i], max_ascii_char));
        assert(range_proof(min_ascii_char, solution[i], max_ascii_char));

        // Assert that the guess and solution char are all different
        for j in (i+1)..4 {
            assert(guess[i] != guess[j]);
            assert(solution[i] != solution[j]);
        }
    }

    // Count hit & blow
    let mut hit = 0;
    let mut blow = 0;
    
    for i in 0..4 {
        for j in 0..4 {
            let eq = if (guess[i] == solution[j]) {
                1
            } else {
                0
            };

            blow += eq;

            if (i == j) {
                hit += eq;
                blow -= eq;
            }
        }
    }

    // Assert the number of hit
    assert(hit == num_hit);

    // Assert the number of blow
    assert(blow == num_blow);

    // Verify that the hash of the solution matches solution_hash
    let prep_solution: Field = (solution[0] as u32 + 
                        solution[1] as u32 * 256 +
                        solution[2] as u32 * 256 * 256 +
                        solution[3] as u32 * 256 * 256 * 256).into();

    let hash = std::hash::poseidon::bn254::hash_2([prep_solution, salt]);

    assert(solution_hash == hash);
    
    hash
}
