// deposit.nr
// A ZK proof that we updated a Merkle tree correctly

// Import pedersen and merkle helpers
use barretenberg::pedersen::pedersen;
use barretenberg::merkle::{merkle_root, MerklePath};

struct PrivateInputs {
    id: Field,
    r: Field,
    old_path: MerklePath<8>,
}
struct PublicInputs {
    old_root: Field,
    new_root: Field,
    commitment: Field,
    index: u32,
}

fn main(priv: PrivateInputs, pub_in: PublicInputs) {
    // 1) Check commitment = Pedersen(id, r)
    let computed = pedersen([priv.id, priv.r]);
    computed.assert_equal(pub_in.commitment);

    // 2) Check old_root matches path root
    let path_root = merkle_root(
        pub_in.commitment,         // leaf
        priv.old_path.elements,    // siblings
        priv.old_path.indices,     // indices
    );
    path_root.assert_equal(pub_in.old_root);

    // 3) Compute new root inserting at index
    let new_root_calc = merkle_root(
        pub_in.commitment,         // same leaf
        priv.old_path.elements,    // same path
        priv.old_path.indices,     // same indices
    );
    new_root_calc.assert_equal(pub_in.new_root);
}
