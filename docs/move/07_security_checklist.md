# Security checklist (pre-publish)

- [ ] **Ownership**: Every `public entry` validates caller owns all consumed objects.
- [ ] **Capabilities**: Sensitive ops gated by capability or admin address check.
- [ ] **Abilities**: Minimal needed; no accidental `copy`/`drop` on resources.
- [ ] **State transitions**: Invariants preserved on every path.
- [ ] **Shared objects**: Necessary? correct `&mut` usage? contention considered?
- [ ] **Reentrancy-like patterns**: Avoid exposing callbacks or external code exec.
- [ ] **Event coverage**: Emit events for critical state changes.
- [ ] **Error codes**: Deterministic and documented.
- [ ] **Testing**: Positive + negative tests; boundary conditions (0, max, empty).
- [ ] **Upgrade plan**: Versioning fields, migrations considered.
