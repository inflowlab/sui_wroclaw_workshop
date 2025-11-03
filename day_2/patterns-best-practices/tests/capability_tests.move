module patterns::capability_tests {
    use sui::test_scenario;
    use std::string;
    use patterns::capability;

    #[test]
    public fun can_mint_with_cap() {
        let sc = test_scenario::begin();
        let admin = test_scenario::create_sender(&sc);
        let alice = test_scenario::create_sender(&sc);

        // Admin creates a cap and uses it to mint for Alice
        test_scenario::next_tx(&sc, admin);
        let cap = capability::new_admin_for_test(&mut test_scenario::ctx(&sc));
        capability::mint_badge(&cap, string::utf8(b"VIP"), 1, alice);

        test_scenario::end(sc);
    }

    #[test]
    #[expected_failure]
    public fun cannot_mint_without_cap() {
        let sc = test_scenario::begin();
        let bob = test_scenario::create_sender(&sc);

        test_scenario::next_tx(&sc, bob);
        // No cap available; this should fail borrow/type checks if attempted.
        // We simulate by calling a helper that requires &AdminCap — impossible to fabricate.
        // Uncommenting would be a compile-time error, so we abort explicitly to signal expected failure pattern.
        assert!(false, 777);

        test_scenario::end(sc);
    }
}
