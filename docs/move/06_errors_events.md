# Errors & Events

**Error codes**
- Define constants; group by domain.
```move
const ENotOwner: u64 = 0;
const EPaused: u64 = 1;
```

## Fail early
- Check ownership, capabilities, bounds before mutation.

## Events
- Emit small, stable, versioned event structs.
```move
struct IncEvent has copy, drop, store { new_value: u64 }
public fun emit_inc(v: u64) { sui::event::emit(IncEvent { new_value: v }); }
```

## Event design tips
- Prefer primitive fields; avoid embedding whole objects.
- Include identifiers necessary for off-chain indexing.
