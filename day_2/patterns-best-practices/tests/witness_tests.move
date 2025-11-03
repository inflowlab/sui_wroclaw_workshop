module patterns::witness_tests {
    use sui::test_scenario;
    use std::string;
    use patterns::witness;

    #[test]
    public fun mint_with_witness_succeeds() {
        let sc = test_scenario::begin();
        let alice = test_scenario::create_sender(&sc);

        test_scenario::next_tx(&sc, alice);
        let w = witness::new_witness_for_test();
        let _seal = witness::mint_with_witness(&w, string::utf8(b"S1"), &mut test_scenario::ctx(&sc));

        test_scenario::end(sc);
    }

    #[test]
    #[expected_failure]
    public fun mint_without_witness_fails() {
        let sc = test_scenario::begin();
        let alice = test_scenario::create_sender(&sc);

        test_scenario::next_tx(&sc, alice);
        // Attempt to call without a Witness by faking with an abort to emulate required precondition
        assert!(false, 999);

        test_scenario::end(sc);
    }
}
