// circuits/deposit-circuit/src/deposit.nr

import std::hash::pedersen::{pedersen_hash};
import std::merkle::{merkle_update};

// note camelCase on oldPath, and pub on the last four inputs in this order
fn main(
    id: Field,
    r: Field,
    oldPath: [Field; 8],         // matches the demo’s `oldPath` key

    oldRoot: pub Field,          // matches `oldRoot`
    newRoot: pub Field,          // matches `newRoot`
    commitment: pub Field,       // matches `commitment`
    index: pub Field             // matches `index`
) {
    // 1) Check your Pedersen commitment
    let computed = pedersen_hash([id, r]);
    computed.assert_eq(commitment);

    // 2) Verify update of the Merkle root
    let updated = merkle_update(oldRoot, commitment, index, oldPath);
    updated.assert_eq(newRoot);
}
