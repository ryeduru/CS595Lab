import std::hash::pedersen::{pedersen_hash};
import std::merkle::{merkle_update};

// Must match your Deposit TOML keys & order:
//   id, r, oldPath, oldRoot, newRoot, commitment, index
fn main(
    id: Field,
    r: Field,
    oldPath: [Field; 8],    // ⬅️ key=`oldPath`

    oldRoot: pub Field,     // ⬅️ key=`oldRoot`
    newRoot: pub Field,     // ⬅️ key=`newRoot`
    commitment: pub Field,  // ⬅️ key=`commitment`
    index: pub Field        // ⬅️ key=`index`
) {
    // 1) commitment == PedersenHash(id, r)
    let comp = pedersen_hash([id, r]);
    comp.assert_eq(commitment);

    // 2) inserting commitment at index in tree rooted at oldRoot 
    //    produces newRoot
    let got = merkle_update(oldRoot, commitment, index, oldPath);
    got.assert_eq(newRoot);
}
