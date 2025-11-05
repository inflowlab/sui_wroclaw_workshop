# Sui Objects: ownership, transfers, dynamic fields

**Object basics**
- Sui object = struct with `id: UID` and `has key`.
- Ownership kinds: **owned (address)**, **shared**, **immutable**.

**Create / transfer / delete**
```move
use sui::object;
use sui::transfer;
use sui::tx_context::TxContext;

public entry fun create(ctx: &mut TxContext): MyObj {
    MyObj { id: object::new(ctx), value: 0 }
}

public entry fun give(o: MyObj, recipient: address) {
    transfer::public_transfer(o, recipient);
}

// delete by consuming (ensure invariants)
public entry fun burn(o: MyObj) { /* move out fields, then implicitly drop UID? no — consume properly */ }
```

**Shared objects**
- Marked shared via publishing and explicit share.
- Require consensus for mutation; use sparingly.
- Entry funcs must accept &mut to mutate shared state.

**Dynamic fields / collections**
- `sui::dynamic_field` for key/value attached to an object.
- Useful to avoid huge monolithic objects.

**Coins**
- `sui::coin` utilities; merging/splitting preserves totals.

**Events**
- Use `sui::event::emit<T>(&T)` to signal off-chain consumers.

**Gotchas**
- Don’t leak UID.
- Validate sender owns objects passed by value.
- Be explicit about mutability: & vs &mut.