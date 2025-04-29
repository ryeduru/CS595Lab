import std::hash::pedersen::{pedersen_hash};
import std::merkle::{merkle_verify};

// Must match your Withdraw TOML keys & order:
//   r, index, hashpath, root, id
fn main(
    r: Field,
    index: Field,
    hashpath: [Field; 8],   // ⬅️ key=`hashpath`

    root: pub Field,        // ⬅️ key=`root`
    id: pub Field           // ⬅️ key=`id`
) {
    // recompute the commitment from the nullifier `id` and randomness `r`
    let commitment = pedersen_hash([id, r]);

    // assert that commitment lives at `index` in tree with root `root`
    merkle_verify(commitment, index, hashpath, root);
}
