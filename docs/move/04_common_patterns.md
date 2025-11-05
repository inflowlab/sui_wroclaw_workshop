# Common Sui Move patterns

## 1) Capability / Witness
Grant powers explicitly via a resource token.

```move
struct AdminCap has key { id: UID }
public entry fun create_admin(ctx: &mut TxContext): AdminCap { AdminCap { id: object::new(ctx) } }
public fun require_admin(_cap: &AdminCap) { /* presence proves authorization */ }
```

## 2) Access control via address lists
```move
struct Config has key {
  id: UID,
  admin: address,
}
public fun assert_admin(cfg: &Config, caller: address) { assert!(cfg.admin == caller, 0); }
```

## 3) Non-fungible assets (simple)
```move
struct NFT has key { id: UID, name: string::String }
public entry fun mint(name: String, ctx: &mut TxContext): NFT { /* ... */ }
```

## 4) Registry with dynamic fields
Attach per-user entries to a root object.

## 5) Pausable
Keep a paused: bool flag; gate entry functions.

## 6) Upgradability
- Keep state schema stable; add fields compatibly.
- Use version fields to manage migrations.

# Anti-patterns
- Overusing shared objects for convenience.
- Mixing authorization, business logic, and storage in the same function.
