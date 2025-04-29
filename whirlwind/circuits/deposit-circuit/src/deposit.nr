// deposit.nr
// Private inputs: id, r, old_path
// Public inputs: old_root, new_root, commitment, index

import std::hash::pedersen::{pedersen_hash};
import std::merkle::{merkle_update};

fn main(
    id: Field,
    r: Field,
    old_path: [Field; 8],     // adjust depth if needed
    index: Field,
    old_root: Field,
    new_root: Field,
    commitment: Field
) {
    // 1) Check commitment = PedersenHash(id, r)
    let computed = pedersen_hash([id, r]);
    computed.assert_eq(commitment);

    // 2) Check that inserting `commitment` at `index` in tree with root `old_root`
    //    yields `new_root`, given `old_path`
    let computed_root = merkle_update(old_root, commitment, index, old_path);
    computed_root.assert_eq(new_root);
}
