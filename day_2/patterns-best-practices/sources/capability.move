module patterns_best_practices::capability {
    use std::string::{Self, String};
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use sui::event;

    public struct AdminCap has key { id: UID }
    public struct Badge has store { name: String, serial: u64 }
    public struct Minted has copy, drop { name: String, serial: u64, to: address }

    fun init(ctx: &mut TxContext) {
        let cap = AdminCap { id: object::new(ctx) };
        transfer::transfer(cap, tx_context::sender(ctx));
    }

    public fun mint_badge(_cap: &AdminCap, name: String, serial: u64, recipient: address) {
        // Gated by possession of &_cap
        event::emit(Minted { name, serial, to: recipient });
        let _b = Badge { name: String::empty(), serial }; // illustrative placeholder
    }

    /// TEST helper: create AdminCap and return (no transfer), for clean unit tests.
    #[test_only]
    public fun new_admin_for_test(ctx: &mut TxContext): AdminCap {
        AdminCap { id: object::new(ctx) }
    }
}
