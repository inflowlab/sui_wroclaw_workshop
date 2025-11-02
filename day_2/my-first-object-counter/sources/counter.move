module my_first_object_counter::counter {

    /// Error codes
    const ERR_NOT_OWNER: u64 = 1;

    /// A simple Sui object with an owner and a numeric value.
    public struct MyCounter has key {
        id: UID,            // required first field for Sui objects
        owner: address,     // current owner
        value: u64,         // current count
    }

    /// Create a new MyCounter owned by the transaction sender, starting at 0.
    public fun create_counter(ctx: &mut TxContext) {
        let me = tx_context::sender(ctx);
        let c = MyCounter { id: object::new(ctx), owner: me, value: 0 };
        transfer::transfer(c, me);
    }

    /// Owner‑only: increment the counter by 1.
    /// Takes &mut Counter which proves caller owns the object.
    public fun increment(c: &mut MyCounter, ctx: &mut TxContext) {
        assert!(tx_context::sender(ctx) == c.owner, ERR_NOT_OWNER);
        c.value = c.value + 1;
    }

    /// Owner‑only: reset the counter to 0.
    public fun reset(c: &mut MyCounter, ctx: &mut TxContext) {
        assert!(tx_context::sender(ctx) == c.owner, ERR_NOT_OWNER);
        c.value = 0;
    }

    /// Transfer the MyCounter to a new owner.
    public fun transfer_counter(c: MyCounter, new_owner: address, ctx: &mut TxContext) {
        assert!(tx_context::sender(ctx) == c.owner, ERR_NOT_OWNER);
        let mut c = c;
        c.owner = new_owner;
        // move the whole object to the new owner
        transfer::transfer(c, new_owner);
    }

    /// Helper: read-only view of the value (pure helper for offchain or tests).
    public fun get_value(c: &MyCounter): u64 { c.value }

}
