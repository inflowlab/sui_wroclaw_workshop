module my_first_object_counter::counter_tests {
    use sui::test_scenario;
    use my_first_object_counter::counter;

    const SENDER: address = @0x1;
    const RECIPIENT: address = @0x3;

    /// Positive path (scaffold): create then (students) increment + assert.
    #[test]
    public fun create_and_increment() {
        let mut sc = test_scenario::begin(SENDER);

        // TX1: SENDER creates a counter
        test_scenario::next_tx(&mut sc, SENDER);
        counter::create_counter(test_scenario::ctx(&mut sc));

        // TODO: Students fetch SENDER's Counter object and call increment,
        // then verify value via counter::get_value.

        test_scenario::end(sc);
    }

    /// Negative path (scaffold): non-owner cannot increment (should fail with code 1)
    #[test]
    #[expected_failure]
    public fun non_owner_cannot_increment() {
        let mut sc = test_scenario::begin(SENDER);

        // TX1: SENDER creates a counter
        test_scenario::next_tx(&mut sc, SENDER);
        counter::create_counter(test_scenario::ctx(&mut sc));

        // TX2: RECIPIENT attempts to increment SENDER's counter
        // TODO: Students fetch SENDER's Counter object under RECIPIENT's tx and call increment(&mut).
        // This should fail with ERR_NOT_OWNER = 1.

        test_scenario::end(sc);
    }
}
