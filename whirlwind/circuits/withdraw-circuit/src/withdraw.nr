// withdraw.nr
// A ZK proof that a commitment exists in the tree

use barretenberg::pedersen::pedersen;
use barretenberg::merkle::{merkle_root, MerklePath};

struct PrivateInputs {
    id: Field,
    r: Field,
    path: MerklePath<8>,
}
struct PublicInputs {
    root: Field,
    nullifier: Field,
}

fn main(priv: PrivateInputs, pub_in: PublicInputs) {
    // Recompute commitment and nullifier
    let commitment = pedersen([priv.id, priv.r]);
    let computed_nullifier = priv.id;      // id itself is the nullifier
    computed_nullifier.assert_equal(pub_in.nullifier);

    // Check the path leads to root
    let path_root = merkle_root(
        commitment,
        priv.path.elements,
        priv.path.indices,
    );
    path_root.assert_equal(pub_in.root);
}
