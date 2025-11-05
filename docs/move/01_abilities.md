# Abilities & type design

**Abilities**
- `copy`: values can be duplicated.
- `drop`: values can be discarded.
- `store`: values can be stored in global state (in fields).
- `key`: values can be used as top-level stored resources (Sui: object roots).

**Design tips**
- Resources normally **do not** have `copy`/`drop`. Give only what you need.
- Add `store` only if placed in another struct.
- Add `key` only for root objects (Sui object pattern).

**Examples**

```move
module my::coin {
    use sui::object::{Self, UID};
    use sui::tx_context::TxContext;

    /// Root object -> must have `key`
    struct Vault has key {
        id: UID,
        balance: u64,
    }

    /// Plain data inside an object -> needs `store`
    struct Config has store {
        limit: u64
    }

    public entry fun create(ctx: &mut TxContext): Vault {
        Vault { id: object::new(ctx), balance: 0 }
    }
}
```

**Anti-patterns**
-Over-assigning abilities “just in case”.
-Adding key to helper structs (they become independent objects unintentionally).
