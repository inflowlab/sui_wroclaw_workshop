module objects_demo::objects_demo {
    
    use std::string::{String};
    use sui::event;

    public struct Item has key {
        id: UID,
        name: String,
    }

    public struct Created has copy, drop { obj_id: object::ID, name: String }
    public struct Updated has copy, drop { obj_id: object::ID, new_name: String }
    public struct Transferred has copy, drop { obj_id: object::ID, to: address }

    public fun create_item(name: String, ctx: &mut TxContext) {
        //TODO: create Item object: let item ...
        event::emit(Created { obj_id: object::id(&item), name: item.name });
        //TODO: transfer the Item object to the sender
    }

    public fun rename_item(item: &mut Item, new_name: String) { // Why do we use &mut?
        item.name = new_name;
        //TODO: emit Updated event
    }

    public fun transfer_item(item: Item, recipient: address) {
        event::emit(Transferred { obj_id: object::id(&item), to: recipient });
        //TODO: transfer the Item object to the recipient
    }

    public fun get_item_name(item: &Item): String {
        item.name
    }
}
