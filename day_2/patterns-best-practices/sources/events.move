module patterns_best_practices::events {
    use std::string::String;
    use sui::event;

    public struct Badge has key { id: UID, name: String }
    public struct Minted has copy, drop { add: address, name: String, to: address }
    public struct Renamed has copy, drop { object: address, new_name: String }
    public struct Transferred has copy, drop { object: address, to: address }

    /// ENTRY: Mint a new `Badge` with `name`, emit a `Minted` event, and
    /// transfer it to the transaction sender.
    public fun mint(name: String, ctx: &mut TxContext) {
        let b = Badge { id: object::new(ctx), name };
        event::emit(Minted { add: tx_context::sender(ctx), name: name, to: tx_context::sender(ctx) });
        transfer::transfer(b, tx_context::sender(ctx));
    }

    /// ENTRY: Rename an existing `Badge` and emit a `Renamed` event.
    public fun rename( b: &mut Badge, new_name: String) {
        b.name = new_name;
        event::emit(Renamed { object: object::id_address(b), new_name });
    }

    /// ENTRY: Transfer a `Badge` to `to` and emit a `Transferred` event.
    public fun send(b: Badge, to: address) {
        event::emit(Transferred { object: object::id_address(&b), to });
        transfer::transfer(b, to);
    }
}
