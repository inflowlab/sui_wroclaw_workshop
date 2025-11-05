# Testing Move

**Unit tests (pure Move)**
- Place under `tests/` or use `#[test]` functions in modules under `sources/` (test-only code is not published).
- Run with `sui move test`.

**Assertions & expected failures**
```move
#[test]
fun basic_math() {
    let x = 2;
    assert!(x + 2 == 4, 0);
}

#[test, expected_failure(abort_code = 0)]
fun failing_case() {
    abort 0;
}
```

## Patterns
- Given/When/Then naming: test_create_initializes_zero, test_inc_increases_by_one.
- Use helper functions visible only to tests (guarded by #[test_only] if available) or place in tests/ modules.

## E2E ideas (outside pure Move)
- Script mint -> transfer -> assert balances via events/logs.
- Simulate multiple owners and shared object mutations.

