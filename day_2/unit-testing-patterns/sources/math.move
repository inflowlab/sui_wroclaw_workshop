module unit_testing_patterns::math {

    const ERR_DIV_ZERO: u64 = 100;

    public fun add(a: u64, b: u64): u64 { a + b }

    public fun safe_div(a: u64, b: u64): u64 {
        assert!(b != 0, ERR_DIV_ZERO);
        a / b
    }
}
