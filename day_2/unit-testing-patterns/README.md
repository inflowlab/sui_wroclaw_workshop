# 🧪 Unit Testing Patterns in Sui Move (45 min)

> Focus: `#[test]`, `#[expected_failure]`, positive/negative tests, and when to use `sui::test_scenario`.

---

## Why test in Move?
Move’s type/ability system prevents many bugs, but logic errors and access control mistakes still happen. Good tests:
- Guard invariants
- Exercise happy and unhappy paths
- Document behavior with named error codes

## Styles
1) Pure unit tests (call pure functions directly)  
2) Scenario tests using `sui::test_scenario` for TxContext/object flows

## Attributes
- `#[test]` — mark a function as a test
- `#[expected_failure]` — test should abort; otherwise, it's a failure

## Run
```bash
sui move test
sui move test --filter tiny_counter
```

## Structure
```
unit-testing-patterns/
├─ README.md
├─ sources/
│  ├─ math.move
│  ├─ vault.move
│  └─ tiny_counter.move
└─ tests/
   ├─ math_tests.move
   ├─ vault_tests.move
   └─ tiny_counter_tests.move
```
