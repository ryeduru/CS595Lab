// withdraw circuit: prove a leaf (commitment) exists in the tree

// inputs:
//   id, r: secret nullifier and randomness
//   path: 8 sibling hashes
// public inputs:
//   index, root

fn main(
    id: Field,
    r: Field,
    path: [Field; 8],
    pub index: Field,
    pub root: Field,
) {
    // 1) recompute the commitment
    let comm = std::hash::pedersen(&[id, r])[0];

    // 2) recompute the Merkle root from that leaf
    let calc = std::merkle::compute_merkle_root(comm, index, path);
    assert(calc == root);
}
