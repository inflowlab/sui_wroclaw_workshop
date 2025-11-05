# Move @ a glance (Sui-flavored)

**Core ideas**
- Linear types: resources cannot be copied or implicitly dropped.
- Safety via **abilities** (`copy`, `drop`, `store`, `key`).
- Modules define types + functions with explicit visibility.
- On Sui: objects (with `UID`) live on-chain; ownership & transfers are first-class.

**Project layout (typical)**
- `Move.toml` — package name, addresses, deps.
- `sources/` — modules.
- `tests/` — unit tests (pure Move) and e2e helpers.

**Golden rules**
- Public(entry) functions validate **caller intent + object ownership**.
- Keep invariants with small, composable internal functions.
- Prefer emitting events over implicit state observation.
- Make invalid states unrepresentable via types and abilities.

**CLI quick refs**
```bash
sui move build
sui move test
sui client publish --gas-budget <N>    # in a Sui client context
```