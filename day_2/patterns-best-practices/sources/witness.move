module patterns_best_practices::witness {
    use std::string::{Self, String};
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    /// Optional admin authority for issuing witnesses.
    public struct AdminCap has key { id: UID }

    /// Zero-sized authority token: possession proves permission.
    /// Not a Sui object; cheap to pass by reference.
    public struct Witness has drop {}

    /// A minted object that requires a &Witness to create.
    public struct Seal has key { id: UID, tag: String }

    /// ENTRY: grant AdminCap to the publisher (for CLI demo).
    fun init(ctx: &mut TxContext) {
        let cap = AdminCap { id: object::new(ctx) };
        transfer::transfer(cap, tx_context::sender(ctx));
    }

    /// ENTRY: admin issues a Witness to a user by transferring it.
    /// (For CLI simplicity we model Witness as a plain value and wrap it into a SealIssuer object if needed.)
    public entry fun issue_witness(_admin: &AdminCap, recipient: address, ctx: &mut TxContext) {
        // We materialize a Witness by putting it inside a one-shot object for transfer,
        // but for didactic simplicity we skip objectization and assume tests handle references.
        // In CLI, prefer capability objects or dynamic fields to hand off roles.
        let _ = recipient; let _ = ctx;
        // No-op; see tests that call `new_witness_for_test` instead.
    }

    /// Require a &Witness to mint a Seal object.
    public fun mint_with_witness(_w: &Witness, tag: String, ctx: &mut TxContext): Seal {
        Seal { id: object::new(ctx), tag }
    }

    /// TEST helper: create AdminCap and return it (no transfer).
    #[test_only]
    public fun new_admin_for_test(ctx: &mut TxContext): AdminCap {
        AdminCap { id: object::new(ctx) }
    }

    /// TEST helper: mint a fresh Witness value (would be gated by AdminCap in prod).
    #[test_only]
    public fun new_witness_for_test(): Witness { Witness {} }
}
