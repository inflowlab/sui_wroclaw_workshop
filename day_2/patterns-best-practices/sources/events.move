module patterns::events {
    use std::string::{Self, String};
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use sui::event;

    public struct Badge has key { id: UID, name: String }
    public struct Minted has copy, drop { object: address, name: String, to: address }
    public struct Renamed has copy, drop { object: address, new_name: String }
    public struct Transferred has copy, drop { object: address, to: address }

    public entry fun mint(name: String, ctx: &mut TxContext) {
        let b = Badge { id: object::new(ctx), name };
        let oid = object::id_to_address(&b.id);
        event::emit(Minted { object: oid, name: b.name.clone(), to: tx_context::sender(ctx) });
        transfer::transfer(b, tx_context::sender(ctx));
    }

    public entry fun rename(b: &mut Badge, new_name: String) {
        b.name = new_name.clone();
        let oid = object::id_to_address(&b.id);
        event::emit(Renamed { object: oid, new_name });
    }

    public entry fun send(b: Badge, to: address) {
        let oid = object::id_to_address(&b.id);
        event::emit(Transferred { object: oid, to });
        transfer::transfer(b, to);
    }
}
