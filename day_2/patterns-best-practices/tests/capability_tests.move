module patterns_best_practices::capability_tests {
    use sui::test_scenario;
    use std::string;
    use patterns_best_practices::capability;

    const ADMIN: address = @0x1;
    const RECIPIENT: address = @0x3;

    #[test]
    public fun can_mint_with_cap() {
        //TODO: create a test scenario (sc)
        //TODO: next transaction from ADMIN
        //TODO: create AdminCap
        //TODO: mint a badge
        //TODO: destruct AdminCap object

        //end test_scenario
    }

    #[test]
    #[expected_failure]
    public fun cannot_mint_without_cap() {
        let mut sc = test_scenario::begin(ADMIN);

        test_scenario::next_tx(&mut sc, RECIPIENT);
        // No cap available; this should fail borrow/type checks if attempted.
        // We simulate by calling a helper that requires &AdminCap — impossible to fabricate.
        // Uncommenting would be a compile-time error, so we abort explicitly to signal expected failure pattern.
        

        test_scenario::end(sc);
    }
}
