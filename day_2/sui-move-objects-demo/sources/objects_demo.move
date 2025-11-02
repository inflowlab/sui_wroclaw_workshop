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
        let item = Item { id: object::new(ctx), name };
        event::emit(Created { obj_id: object::id(&item), name: item.name });
        transfer::transfer(item, tx_context::sender(ctx));
    }

    public fun rename_item(item: &mut Item, new_name: String) {
        item.name = new_name;
        event::emit(Updated { obj_id: object::id(item), new_name });
    }

    public fun transfer_item(item: Item, recipient: address) {
        event::emit(Transferred { obj_id: object::id(&item), to: recipient });
        transfer::transfer(item, recipient);
    }

    public fun get_item_name(item: &Item): String {
        item.name
    }
}
