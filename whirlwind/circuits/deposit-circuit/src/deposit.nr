// deposit.nr
// Public inputs: oldRoot, newRoot, commitment, index
// Private inputs: id, r, oldPath (Merkle authentication path)

const DEPTH = 8; // match your off-chain tree depth

import "std/hash/blake2s.nr" as blake2s;
import "std/merkle_tree.nr" as merkle;

fn main(
  oldRoot: Field,
  newRoot: Field,
  commitment: Field,
  index: Field
) {
    // Private
    id: Field = pubonly();      // secret
    r: Field  = pubonly();      // randomness
    oldPath: [Field; DEPTH] = pubonly();
    oldIndices: [u8; DEPTH] = pubonly();

    // 1) commitment = H(id || r)
    let computed = blake2s::hash([id, r]);
    computed.assert_equal(commitment);

    // 2) verify oldRoot with path
    merkle::verify_membership(commitment, index.to_u32(), oldPath, oldIndices, oldRoot);

    // 3) compute new root and enforce equality
    let calcRoot = merkle::update_root(commitment, index.to_u32(), oldPath, oldIndices);
    calcRoot.assert_equal(newRoot);
}

