module patterns_best_practices::capability {
    use std::string::{Self, String};
    use sui::event;

    public struct AdminCap has key { id: UID }
    public struct Badge has key { id: UID, name: String, serial: u64 }
    public struct Minted has copy, drop { name: String, serial: u64, to: address }

    /// Init helper: mint an `AdminCap` and transfer it to the publisher
    /// (transaction sender). Intended for setup/demo flows.
    fun init(ctx: &mut TxContext) {
        //TODO: Create AdminCap object
        //TODO: get a sender address
        //TODO: transfer to sender
    }

    /// Mint a `Badge` gated by possession of `&_cap`. Emits a `Minted` event
    /// and transfers the newly created `Badge` to `recipient`.
    public fun mint_badge(_cap: &AdminCap, name: String, serial: u64, recipient: address, ctx: &mut TxContext) {
        event::emit(Minted { name, serial, to: recipient });
        //TODO: create a Badge object
        //TODO: transfer the minted object to the recipient
    }

    /// TEST helper: create AdminCap and return (no transfer), for clean unit tests.
    #[test_only]
    public fun new_admin_for_test(ctx: &mut TxContext): AdminCap {
        AdminCap { id: object::new(ctx) }
    }

    #[test_only]
    public fun destruct_for_test(cap: AdminCap) {
        let AdminCap { id } = cap;
        id.delete();
    }
}
