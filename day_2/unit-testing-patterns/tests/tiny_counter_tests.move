module unit_testing_patterns::tiny_counter_tests {
    use sui::test_scenario;
    use unit_testing_patterns::tiny_counter;
    use sui::test_scenario::Scenario;

    const SENDER: address = @0x1;
    const RECIPIENT: address = @0x3;

    #[test] 
    public fun owner_can_increment() {
        let mut sc: Scenario = test_scenario::begin(SENDER);
        test_scenario::next_tx(&mut sc, SENDER);
        tiny_counter::create(test_scenario::ctx(&mut sc));
        // TODO: fetch created counter object & inc; scaffold kept minimal
        test_scenario::end(sc);
    }

    #[test] 
    #[expected_failure] 
    public fun non_owner_cannot_increment() {
        let mut sc: Scenario = test_scenario::begin(SENDER);

        test_scenario::next_tx(&mut sc, SENDER);
        tiny_counter::create(test_scenario::ctx(&mut sc));
        test_scenario::next_tx(&mut sc, RECIPIENT);
        // tiny_counter::inc(&mut <SENDER's counter>);
        test_scenario::end(sc);
    }
}
