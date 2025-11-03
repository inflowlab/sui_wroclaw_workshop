module patterns::dynamic_fields {
    use std::string::{Self, String};
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use sui::dynamic_field::{Self, add, remove, has};

    public struct Profile has key { id: UID, owner: address }

    /// Create a new Profile owned by the sender.
    public entry fun create(ctx: &mut TxContext) {
        let me = tx_context::sender(ctx);
        let p = Profile { id: object::new(ctx), owner: me };
        transfer::transfer(p, me);
    }

    /// TEST helper: create and return without transfer.
    public fun create_for_test(ctx: &mut TxContext): Profile {
        Profile { id: object::new(ctx), owner: tx_context::sender(ctx) }
    }

    /// Add or update an attribute. Uses dynamic fields keyed by String.
    public entry fun set_attr(p: &mut Profile, key: String, value: String, ctx: &mut TxContext) {
        if (has<String, String>(&p.id, &key)) {
            // Replace by remove+add to avoid borrowing complexities.
            let _old = remove<String, String>(&mut p.id, key);
            // _old dropped
        };
        // Re-add with the new key/value
        add<String, String>(&mut p.id, key, value, ctx);
    }

    /// Query: does attribute exist?
    public fun has_attr(p: &Profile, key: &String): bool {
        has<String, String>(&p.id, key)
    }
}
