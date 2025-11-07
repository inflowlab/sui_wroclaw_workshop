module patterns_best_practices::access_control {
    use std::string::{Self, String};

    const ERR_NOT_OWNER: u64 = 1;

    public struct Notebook has key { id: UID, owner: address, body: String }

    public entry fun create(body: String, ctx: &mut TxContext) {
        //TODO Get a sender
        //TODO create a Notebook object
        //TODO transfer the Notebook object to the sender
    }

    public fun append_line(n: &mut Notebook, line: String, ctx: &mut TxContext) {
        assert!(tx_context::sender(ctx) == n.owner, ERR_NOT_OWNER);
        string::append(&mut n.body, string::utf8(b"\n"));
        //TODO: add the line to the end of the body
    }

    public fun get_body(n: &Notebook): String { n.body } // Why do we pass via & ?

    public fun transfer_note(n: Notebook, new_owner: address, ctx: &mut TxContext) {
        //TODO: add sender check
        let mut new_n = n; // Why do we need it?
        new_n.owner = new_owner;
        //TODO transfer the Notebook object to the new_owner
    }

    /// TEST helper: create without transfer, return Notebook
    #[test_only]
    public fun create_for_test(body: String, ctx: &mut TxContext): Notebook {
        Notebook { id: object::new(ctx), owner: tx_context::sender(ctx), body }
    }

    /// Why do we need it?
    #[test_only]
    public fun destruct_for_test(note: Notebook) {
        let Notebook { id, owner, body } = note; // Why do we need that?
        id.delete();
    }
}
