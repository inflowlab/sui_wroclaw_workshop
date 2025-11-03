module patterns::dynamic_fields_tests {
    use sui::test_scenario;
    use std::string;
    use patterns::dynamic_fields;

    #[test]
    public fun set_and_check_attr() {
        let sc = test_scenario::begin();
        let alice = test_scenario::create_sender(&sc);

        test_scenario::next_tx(&sc, alice);
        let mut p = dynamic_fields::create_for_test(&mut test_scenario::ctx(&sc));

        let key = string::utf8(b"color");
        let val = string::utf8(b"blue");

        dynamic_fields::set_attr(&mut p, key.clone(), val, &mut test_scenario::ctx(&sc));
        let has = dynamic_fields::has_attr(&p, &key);
        assert!(has, 1);

        test_scenario::end(sc);
    }
}
