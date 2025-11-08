module market::marketplace {
    use std::string::{Self, String};
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use sui::event;
    use sui::coin::{Self, Coin};
    use sui::sui::SUI;

    /// Errors
    const E_NOT_SELLER: u64 = 1;
    const E_NOT_BUYER: u64 = 2;
    const E_INACTIVE: u64 = 3;

    /// A listing created by a seller.
    public struct Listing has key, store {
        id: UID,
        seller: address,
        price: u64,
        item: String,
        active: bool,
    }

    /// Escrow holds Coin<SUI> until release/refund.
    /// Owned by the buyer to ensure buyer consent before releasing.
    public struct Escrow has key {
        id: UID,
        listing_addr: address, // identifier of the listing (for tracing)
        seller: address,
        buyer: address,
        amount: u64,
        coin: Coin<SUI>,
    }

    public struct Listed has copy, drop { listing: address, seller: address, price: u64, item: String }
    public struct Purchased has copy, drop { listing: address, buyer: address, amount: u64 }
    public struct Released has copy, drop { listing: address, buyer: address, seller: address, amount: u64 }
    public struct Refunded has copy, drop { listing: address, buyer: address, seller: address, amount: u64 }

    /// Create a listing owned by the seller (tx sender).
    public entry fun create_listing(item: String, price: u64, ctx: &mut TxContext) {
        let seller = tx_context::sender(ctx);
        let l = Listing { id: object::new(ctx), seller, price, item, active: true };
        let addr = object::id_address(&l);
        // let item_for_event = item;
        event::emit(Listed { listing: addr, seller, price: l.price, item: l.item });
        transfer::public_share_object(l);
    }

    /// Buyer pays into escrow with Coin<SUI> (can be larger than price).
    /// If larger, split: escrow exactly `price`, return change to buyer.
    public entry fun buy(l: &mut Listing, mut payment: Coin<SUI>, ctx: &mut TxContext) {
        assert!(l.active, E_INACTIVE);

        let buyer = tx_context::sender(ctx);
        let price = l.price;

        // Split off 'price' from 'payment' into 'esc_coin'. Remaining 'payment' is change.
        let esc_coin = coin::split(&mut payment, price, ctx);
        // Return change (if any) back to buyer
        transfer::public_transfer(payment, buyer);

        // Create escrow object owned by buyer
        let listing_addr = object::id_address(l);
        let escrow = Escrow {
            id: object::new(ctx),
            listing_addr,
            seller: l.seller,
            buyer,
            amount: price,
            coin: esc_coin,
        };
        event::emit(Purchased { listing: listing_addr, buyer, amount: price });
        transfer::transfer(escrow, buyer);

        // Mark listing inactive (reserved)
        l.active = false;
    }

    /// Buyer confirms delivery -> release funds to seller, close escrow, deactivate listing.
    public entry fun confirm_delivery(e: Escrow, l: &mut Listing, ctx: &mut TxContext) {
        assert!(tx_context::sender(ctx) == e.buyer, E_NOT_BUYER);

        let Escrow{id,listing_addr, seller, buyer, amount, coin} = e;

        // Transfer the escrowed coin to the seller
        transfer::public_transfer(coin, seller);
        // Close escrow object
        object::delete(id);

        // Deactivate listing to prevent reuse
        l.active = false;

        event::emit(Released { listing: listing_addr, buyer: tx_context::sender(ctx), seller, amount });
    }

    public entry fun request_refund(e: Escrow, ctx: &mut TxContext) {
        assert!(tx_context::sender(ctx) == e.buyer, E_NOT_SELLER);
        let seller = e.seller;
        transfer::transfer(e, seller);
    }

    /// Seller refunds buyer -> send coin back to buyer, close escrow, mark listing active (or canceled).
    public entry fun refund_buyer(e: Escrow, l: &mut Listing, ctx: &mut TxContext) {
        assert!(tx_context::sender(ctx) == e.seller, E_NOT_SELLER);

        let Escrow{id,listing_addr, seller, buyer, amount, coin} = e;

        transfer::public_transfer(coin, buyer);
        object::delete(id);

        // Allow relist: set active back to true
        l.active = true;

        event::emit(Refunded { listing: listing_addr, buyer, seller: tx_context::sender(ctx), amount });
    }
}