// withdraw.nr
// Public inputs: root, id (nullifier)
// Private inputs: r, index, path, indices

const DEPTH = 8;

import "std/hash/blake2s.nr" as blake2s;
import "std/merkle_tree.nr" as merkle;

fn main(
  root: Field,
  id: Field
) {
    // Private
    r: Field  = pubonly();
    index: Field = pubonly();
    path: [Field; DEPTH] = pubonly();
    indices: [u8; DEPTH] = pubonly();

    // 1) recompute commitment = H(id || r)
    let commitment = blake2s::hash([id, r]);

    // 2) prove that commitment ∈ tree with given root
    merkle::verify_membership(commitment, index.to_u32(), path, indices, root);

    // nullifier is just `id`, which matches public input
}

