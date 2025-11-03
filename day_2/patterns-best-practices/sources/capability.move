module patterns::capability {
    use std::string::{Self, String};
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use sui::event;

    public struct AdminCap has key { id: UID }
    struct Badge has store { name: String, serial: u64 }
    public struct Minted has copy, drop { name: String, serial: u64, to: address }

    public entry fun init(ctx: &mut TxContext) {
        let cap = AdminCap { id: object::new(ctx) };
        transfer::transfer(cap, tx_context::sender(ctx));
    }

    /// TEST helper: create AdminCap and return (no transfer), for clean unit tests.
    public fun new_admin_for_test(ctx: &mut TxContext): AdminCap {
        AdminCap { id: object::new(ctx) }
    }

    public fun mint_badge(_cap: &AdminCap, name: String, serial: u64, recipient: address) {
        // Gated by possession of &_cap
        event::emit(Minted { name, serial, to: recipient });
        let _b = Badge { name: String::empty(), serial }; // illustrative placeholder
    }
}
