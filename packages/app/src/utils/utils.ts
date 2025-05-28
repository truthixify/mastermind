import { BigNumberish } from 'starknet'
import { FourLetters } from '~~/types'

const solutionInfoKeys = ['solutionArray', 'solutionHash', 'salt']

export enum Stage {
    None = -1,
    Register,
    CommitSolutionHash,
    Playing,
    Reveal
}

export const saveSolutionInfo = (
    solutionArray: FourLetters,
    solutionHash: BigNumberish,
    salt: BigNumberish
) => {
    localStorage.setItem(solutionInfoKeys[0], JSON.stringify(solutionArray))
    localStorage.setItem(solutionInfoKeys[1], solutionHash.toString())
    localStorage.setItem(solutionInfoKeys[2], salt.toString())

    console.log('saveSolutionInfo')
}

export const retrieveSolutionInfo = (): [FourLetters, BigNumberish, BigNumberish] => {
    const solutionArrayStr = localStorage.getItem(solutionInfoKeys[0])
    const solutionHashStr = localStorage.getItem(solutionInfoKeys[1])
    const saltStr = localStorage.getItem(solutionInfoKeys[2])

    if (solutionArrayStr && solutionHashStr && saltStr) {
        return [JSON.parse(solutionArrayStr), BigInt(solutionHashStr), BigInt(saltStr)]
    } else {
        throw new Error('SolutionInfo not found')
    }
}

export const removeSolutionInfo = () => {
    console.log('removeSolutionInfo')
    localStorage.removeItem(solutionInfoKeys[0])
    localStorage.removeItem(solutionInfoKeys[1])
    localStorage.removeItem(solutionInfoKeys[2])
}

export async function generateProof() {}

export const calculateHB = (guess: FourLetters, solution: FourLetters) => {
    const hit = solution.filter((sol, i) => {
        return sol === guess[i]
    }).length

    const blow = solution.filter((sol, i) => {
        return sol !== guess[i] && guess.some(g => g === sol)
    }).length

    return [hit, blow]
}

// function permutations(array: number[], r: number) {
//   // Algorythm copied from Python `itertools.permutations`.
//   var n = array.length;
//   if (r === undefined) {
//     r = n;
//   }
//   if (r > n) {
//     return;
//   }
//   var indices = [];
//   for (var i = 0; i < n; i++) {
//     indices.push(i);
//   }
//   var cycles = [];
//   for (var i = n; i > n - r; i--) {
//     cycles.push(i);
//   }
//   var results = [];
//   var res = [];
//   for (var k = 0; k < r; k++) {
//     res.push(array[indices[k]]);
//   }
//   results.push(res);

//   var broken = false;
//   while (n > 0) {
//     for (var i = r - 1; i >= 0; i--) {
//       cycles[i]--;
//       if (cycles[i] === 0) {
//         indices = indices
//           .slice(0, i)
//           .concat(indices.slice(i + 1).concat(indices.slice(i, i + 1)));
//         cycles[i] = n - i;
//         broken = false;
//       } else {
//         var j = cycles[i];
//         var x = indices[i];
//         indices[i] = indices[n - j];
//         indices[n - j] = x;
//         var res = [];
//         for (var k = 0; k < r; k++) {
//           res.push(array[indices[k]]);
//         }
//         results.push(res);
//         broken = true;
//         break;
//       }
//     }
//     if (broken === false) {
//       break;
//     }
//   }
//   return results;
// }

// export const initCandidates = () => {
//   const numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
//   return permutations(numbers, 4) as FourLetters[];
// };

// export const filterCandidates = (
//   candidates: FourLetters[],
//   guess: FourLetters,
//   hit: number,
//   blow: number
// ) => {
//   if (hit === 0 && blow === 0) {
//     return candidates;
//   }
//   return candidates.filter((digits) => {
//     const unhit = digits.filter((num, i) => {
//       return num !== guess[i];
//     });
//     if (
//       unhit.length === 4 - hit &&
//       unhit.filter((num) => guess.includes(num)).length === blow
//     ) {
//       return true;
//     } else {
//       return false;
//     }
//   });
// };

export const randomSample = (items: FourLetters[]) => {
    return items[Math.floor(Math.random() * items.length)]
}

export const feltToString = (input: bigint | undefined): string => {
    return (
        input
            ?.toString(16)
            .match(/.{2}/g)
            ?.map((c: string) => String.fromCharCode(parseInt(c, 16)))
            .join('') || ''
    )
}
