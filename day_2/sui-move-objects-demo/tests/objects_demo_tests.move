#[test_only]
module objects_demo::objects_demo_tests {
    use std::string;
    use sui::test_scenario;
    use objects_demo::objects_demo::{Self, Item};
    use std::string::String;
    use std::unit_test::assert_eq;

    // Error codes for assertions
    const EItemNotTransferred: u64 = 1;

    const SENDER: address = @0x1;
    const RECIPIENT: address = @0x3;

    #[test]
    public fun create_and_rename_and_transfer() {
        let mut sc = test_scenario::begin(SENDER);

        let item_name: String = string::utf8(b"Sword"); //TODO: create an Item's name
        let new_item_name: String = string::utf8(b"NEW Sword"); // TODO: create a new Item's name (new_item_name)
        objects_demo::create_item(item_name, test_scenario::ctx(&mut sc)); //TODO: Call create_item function

        test_scenario::next_tx(&mut sc, SENDER);
        {
            let mut item: Item = test_scenario::take_from_sender<Item>(&sc);
            assert_eq!(objects_demo::get_item_name(&item), item_name);
            objects_demo::rename_item(&mut item, new_item_name); //TODO: rename_item to new_item_name
            test_scenario::return_to_sender(&sc, item);
        };

        test_scenario::next_tx(&mut sc, SENDER);
        {
            let item: Item = test_scenario::take_from_sender<Item>(&sc); //TODO: take the Item object from the sender
            assert_eq!(item.get_item_name(), new_item_name); //TODO: assert that item.name is equal to new_item_name
            objects_demo::transfer_item(item, RECIPIENT); //TODO: transfer the item object to RECIPIENT
        };
        
        test_scenario::next_tx(&mut sc, SENDER);
        assert!(test_scenario::has_most_recent_for_address<Item>(RECIPIENT), EItemNotTransferred);

        test_scenario::end(sc);
    }
}
