# 🧭 Patterns & Best Practices (60 min)

Focus:
- Capability pattern
- Events
- Basic access control
- Gas & gotchas

See `scripts/demo.md` for CLI walkthrough and `docs/gas_gotchas.md` for gas notes.

---

## ➕ Add-ons in this pack (advanced)

- **Witness pattern** (`witness.move`): issue a `Witness` (optionally via `AdminCap`) and require `&Witness` to mint a `Seal` object.
- **Dynamic fields** (`dynamic_fields.move`): add/update per-object attributes keyed by `String` with `sui::dynamic_field`.
- **Fully-wired tests** (`tests/*.move`): positive/negative for capability, access control, witness, dynamic fields.

Run all tests:
```bash
sui move test
```
