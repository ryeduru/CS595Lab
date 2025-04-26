// deposit circuit: prove you updated the Merkle tree correctly

// inputs:
//   id, r: secret nullifier and randomness
//   path: 8 sibling hashes (private)
// public inputs:
//   index, oldRoot, newRoot, commitment

fn main(
    id: Field,
    r: Field,
    path: [Field; 8],
    pub index: Field,
    pub oldRoot: Field,
    pub newRoot: Field,
    pub commitment: Field,
) {
    // 1) recompute the Pedersen commitment
    let comm = std::hash::pedersen(&[id, r])[0];
    assert(comm == commitment);

    // 2) check oldRoot = merkle(root zero leaf at `index`, path)
    let calc_old = std::merkle::compute_merkle_root(Field::zero(), index, path);
    assert(calc_old == oldRoot);

    // 3) check newRoot = merkle(commitment at `index`, same path)
    let calc_new = std::merkle::compute_merkle_root(comm, index, path);
    assert(calc_new == newRoot);
}
