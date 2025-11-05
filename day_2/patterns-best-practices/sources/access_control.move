module patterns_best_practices::access_control {
    use std::string::{Self, String};
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    const ERR_NOT_OWNER: u64 = 1;

    public struct Notebook has key { id: UID, owner: address, body: String }

    public entry fun create(body: String, ctx: &mut TxContext) {
        let me = tx_context::sender(ctx);
        let n = Notebook { id: object::new(ctx), owner: me, body };
        transfer::transfer(n, me);
    }

    public fun append_line(n: &mut Notebook, line: String, ctx: &mut TxContext) {
        assert!(tx_context::sender(ctx) == n.owner, ERR_NOT_OWNER);
        n.body = n.body + string::utf8(b"\n") + line;
    }

    public fun get_body(n: &Notebook): String { n.body }

    public fun transfer_note(n: &mut Notebook, new_owner: address, ctx: &mut TxContext) {
        assert!(tx_context::sender(ctx) == n.owner, ERR_NOT_OWNER);
        n.owner = new_owner;
        transfer::transfer(n, new_owner);
    }

    /// TEST helper: create without transfer, return Notebook
    #[test_only]
    public fun create_for_test(body: String, ctx: &mut TxContext): Notebook {
        Notebook { id: object::new(ctx), owner: tx_context::sender(ctx), body }
    }
}
