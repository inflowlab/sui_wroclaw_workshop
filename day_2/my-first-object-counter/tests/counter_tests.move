module my_first_object_counter::counter_tests {
    use sui::test_scenario;
    use my_first_object_counter::counter::{Self, MyCounter};
    use std::unit_test::assert_eq;

    const SENDER: address = @0x1;
    const RECIPIENT: address = @0x3;


    #[test]
    public fun create_and_increment() {
        //TODO
    }


    #[test]
    public fun increment_and_transfer() {
        //TODO
    }
}
