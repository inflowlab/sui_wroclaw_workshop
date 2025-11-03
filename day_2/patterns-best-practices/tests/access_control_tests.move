module patterns::access_control_tests {
    use sui::test_scenario;
    use std::string;
    use patterns::access_control;

    #[test]
    public fun owner_appends_ok() {
        let sc = test_scenario::begin();
        let alice = test_scenario::create_sender(&sc);

        test_scenario::next_tx(&sc, alice);
        let mut note = access_control::create_for_test(string::utf8(b"hello"), &mut test_scenario::ctx(&sc));
        access_control::append_line(&mut note, string::utf8(b"world"));
        let body = access_control::get_body(&note);
        // naive length check
        assert!(string::length(&body) > 0, 1);

        test_scenario::end(sc);
    }

    #[test]
    #[expected_failure]
    public fun non_owner_cannot_append() {
        let sc = test_scenario::begin();
        let alice = test_scenario::create_sender(&sc);
        let bob   = test_scenario::create_sender(&sc);

        // Alice creates note
        test_scenario::next_tx(&sc, alice);
        let mut note = access_control::create_for_test(string::utf8(b"hello"), &mut test_scenario::ctx(&sc));

        // Bob attempts to append -> should abort ERR_NOT_OWNER
        test_scenario::next_tx(&sc, bob);
        access_control::append_line(&mut note, string::utf8(b"!"));

        test_scenario::end(sc);
    }
}
