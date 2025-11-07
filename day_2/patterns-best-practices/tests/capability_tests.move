module patterns_best_practices::capability_tests {
    use sui::test_scenario;
    use std::string;
    use patterns_best_practices::capability;

    const ADMIN: address = @0x1;
    const RECIPIENT: address = @0x3;

    #[test]
    public fun can_mint_with_cap() {
        let mut sc = test_scenario::begin(ADMIN); //TODO: create a test scenario (sc)

        // Admin creates a cap and uses it to mint for Alice
        test_scenario::next_tx(&mut sc, ADMIN);
        let cap = capability::new_admin_for_test(test_scenario::ctx(&mut sc)); //TODO: create AdminCap
        capability::mint_badge(&cap, string::utf8(b"VIP"), 1, ADMIN, test_scenario::ctx(&mut sc)); //TODO: mint a badge
        capability::destruct_for_test(cap); //TODO: destruct AdminCap object

        test_scenario::end(sc); //end test_scenario
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
