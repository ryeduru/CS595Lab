// deposit circuit: prove you updated the Merkle tree correctly

// private inputs: id, r, path
// public inputs: index, oldRoot, newRoot, commitment

fn main(
    id: Field,
    r: Field,
    path: [Field; 8],
    pub index: Field,
    pub oldRoot: Field,
    pub newRoot: Field,
    pub commitment: Field,
) {
    // recompute the Pedersen commitment
    let comm = std::hash::pedersen(&[id, r])[0];
    assert(comm == commitment);

    // oldRoot = merkle(zero,    index, path)
    let calc_old = std::merkle::compute_merkle_root(Field::zero(), index, path);
    assert(calc_old == oldRoot);

    // newRoot = merkle(commitment, index, path)
    let calc_new = std::merkle::compute_merkle_root(comm, index, path);
    assert(calc_new == newRoot);
}
