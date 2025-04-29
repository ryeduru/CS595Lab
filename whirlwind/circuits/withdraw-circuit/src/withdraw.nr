// withdraw.nr
// Private inputs: r, index, path
// Public inputs: root, id (nullifier)

import std::hash::pedersen::{pedersen_hash};
import std::merkle::{merkle_verify};

fn main(
    r: Field,
    index: Field,
    path: [Field; 8],    // same tree depth
    root: Field,
    id: Field
) {
    // Recompute commitment from nullifier id and randomness r
    let commitment = pedersen_hash([id, r]);

    // Verify that `commitment` lives in the tree at position `index`, yielding `root`
    merkle_verify(commitment, index, path, root);

    // (the circuit’s public output `id` is your nullifier)
}
