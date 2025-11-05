# Module design & API surface

**Structure**
- Keep a small `public(entry)` API.
- Put checks in **guard functions**; keep state mutation centralized.
- Separate **constructor**, **state transition**, **query** helpers.

**Visibility**
- `public entry` — tx entrypoint (must enforce ownership + invariants).
- `public` — callable by other modules; still enforce preconditions.
- `public(friend)` — controlled extension points.
- `fun` (internal) — building blocks.

**Example skeleton**
```move
module my::counter {
    use sui::object::{Self, UID};
    use sui::tx_context::TxContext;
    use sui::transfer;

    struct Counter has key {
        id: UID,
        value: u64
    }

    // --- constructors
    public entry fun create(ctx: &mut TxContext): Counter { Counter { id: object::new(ctx), value: 0 } }

    // --- transitions
    public entry fun inc(mut c: Counter): Counter { c.value = c.value + 1; c }
    public entry fun transfer_to(c: Counter, to: address) { transfer::public_transfer(c, to) }

    // --- queries (pure)
    public fun get(c: &Counter): u64 { c.value }
}
```

**Docs & comments**
- Document invariants above the type and each entry function.
- Add a short “why exists” header at the top of the module.

