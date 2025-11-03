module unit_testing_patterns::tiny_counter {

    const ERR_NOT_OWNER: u64 = 1;

    public struct MyCounter has key { id: UID, owner: address, value: u64 }

    public fun get_value(c: &MyCounter): u64 { c.value }

    public fun create(ctx: &mut TxContext) {
        let me = tx_context::sender(ctx);
        let c = MyCounter { id: object::new(ctx), owner: me, value: 0 };
        transfer::transfer(c, ctx.sender());
        // In a real contract, transfer c to me; scenario tests can simulate flows as needed.
    }

    public fun inc(c: &mut MyCounter, ctx: &mut TxContext) {
        assert!(tx_context::sender(ctx) == c.owner, ERR_NOT_OWNER);
        c.value = c.value + 1;
    }
}
