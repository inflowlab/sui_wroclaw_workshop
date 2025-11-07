module patterns_best_practices::access_control_tests {
    use sui::test_scenario;
    use std::string;
    use patterns_best_practices::access_control;

    const ADMIN: address = @0x1;
    const RECIPIENT: address = @0x3;

    #[test]
    public fun owner_appends_ok() {
        let mut sc = test_scenario::begin(ADMIN);

        test_scenario::next_tx(&mut sc, ADMIN);
        let mut note = access_control::create_for_test(string::utf8(b"hello"), test_scenario::ctx(&mut sc));
        access_control::append_line(&mut note, string::utf8(b"world"), test_scenario::ctx(&mut sc));
        let body = access_control::get_body(&note);
        // naive length check
        assert!(string::length(&body) > 0, 1);
        access_control::destruct_for_test(note);

        test_scenario::end(sc);
    }

    #[test]
    #[expected_failure]
    public fun non_owner_cannot_append() {
        let mut sc = test_scenario::begin(ADMIN); //TODO: create a test scenario (sc)

        // ADMIN creates note
        test_scenario::next_tx(&mut sc, ADMIN); //TODO: call next transaction (as ADMIN)
        let mut note = access_control::create_for_test(string::utf8(b"hello"), test_scenario::ctx(&mut sc)); //TODO: create a mutable Notebook object

        // RECIPIENT attempts to append -> should abort ERR_NOT_OWNER
        test_scenario::next_tx(&mut sc, RECIPIENT); //TODO: next transaction from RECIPIENT
        access_control::append_line(&mut note, string::utf8(b"!"), test_scenario::ctx(&mut sc)); //TODO: try to append a line to note object
        access_control::destruct_for_test(note); //TODO: destruct the note object

        test_scenario::end(sc); //end test_scenario
    }
}
