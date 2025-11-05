# Glossary (Sui Move)

**Ability** — capability on a type: `copy`, `drop`, `store`, `key`.
**Resource** — non-copyable, non-droppable type (by default).
**Object** — `has key` struct with `UID`, lives on-chain in Sui.
**UID** — unique identifier field for Sui objects.
**Entry function** — `public entry` tx entrypoint.
**Shared object** — object accessible by many; mutated with consensus.
**Dynamic field** — key/value stored under an object, for extensible storage.
**Capability (Cap)** — resource proof that grants permission.
**Event** — on-chain log, emitted for off-chain indexing and UX.
