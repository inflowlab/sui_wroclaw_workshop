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
        //TODO: get a sender address
        //TODO: create MyCounter object
        //TODO: transfer a counter object to the sender
    }

    /// Owner‑only: increment the counter by 1.
    /// Takes &mut Counter which proves caller owns the object.
    public fun increment(c: &mut MyCounter, ctx: &mut TxContext) { //Why do we pass parameter as &mut
        //TODO: check if it's an owner
        //TODO: increment value (+1)
    }

    /// Owner‑only: reset the counter to 0.
    public fun reset(c: &mut MyCounter, ctx: &mut TxContext) {
        //TODO: check if it's an owner
        //TODO: assign 0 to the counter value
    }

    /// Transfer the MyCounter to a new owner.
    public fun transfer_counter(c: MyCounter, new_owner: address, ctx: &mut TxContext) {
        //TODO: check if it's an owner
        //TODO: make a counter mutable
        //TODO: assign new owner
        //TODO: transfer the counter to the new owner
    }

    /// Helper: read-only view of the value (pure helper for offchain or tests).
    public fun get_value(c: &MyCounter): u64 { c.value }

}
