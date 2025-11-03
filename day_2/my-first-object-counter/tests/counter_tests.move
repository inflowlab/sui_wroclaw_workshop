module my_first_object_counter::counter_tests {
    use sui::test_scenario;
    use my_first_object_counter::counter::{Self, MyCounter};
    use std::unit_test::assert_eq;

    const SENDER: address = @0x1;
    const RECIPIENT: address = @0x3;

    /// Positive path (scaffold): create then (students) increment + assert.
    #[test]
    public fun create_and_increment() {
        let mut sc = test_scenario::begin(SENDER);

        // TX1: SENDER creates a counter and increment it
        counter::create_counter(test_scenario::ctx(&mut sc));
        test_scenario::next_tx(&mut sc, SENDER);
        {
            let my_counter: MyCounter = test_scenario::take_from_sender<MyCounter>(&sc);
            assert_eq!(counter::get_value(&my_counter), 0);
            test_scenario::return_to_sender(&sc, my_counter);
        };

        // TODO: Students fetch SENDER's Counter object and call increment,
        // then verify value via counter::get_value.
        test_scenario::next_tx(&mut sc, SENDER);
        {
            let mut my_counter: MyCounter = test_scenario::take_from_sender<MyCounter>(&sc);
            counter::increment(&mut my_counter, test_scenario::ctx(&mut sc));
            test_scenario::return_to_sender(&sc, my_counter);
        };
        test_scenario::next_tx(&mut sc, SENDER);
        {
            let my_counter: MyCounter = test_scenario::take_from_sender<MyCounter>(&sc);
            assert_eq!(counter::get_value(&my_counter), 1);
            test_scenario::return_to_sender(&sc, my_counter);
        };
        

        test_scenario::end(sc);
    }


    #[test]
    public fun increment_and_transfer() {
        let mut sc = test_scenario::begin(SENDER);

        // TX1: SENDER creates a counter
        counter::create_counter(test_scenario::ctx(&mut sc));
        test_scenario::next_tx(&mut sc, SENDER);
        {
            let mut my_counter: MyCounter = test_scenario::take_from_sender<MyCounter>(&sc);
            assert_eq!(counter::get_value(&my_counter), 0);
            counter::increment(&mut my_counter, test_scenario::ctx(&mut sc));
            counter::transfer_counter(my_counter, RECIPIENT, test_scenario::ctx(&mut sc));
        };

        test_scenario::next_tx(&mut sc, RECIPIENT);
        {
            let my_counter: MyCounter = test_scenario::take_from_sender<MyCounter>(&sc);
            assert_eq!(counter::get_value(&my_counter), 1);
            test_scenario::return_to_sender(&sc, my_counter);
        };
        
        test_scenario::end(sc);
    }
}
