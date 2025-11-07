module hello_move_lab::hello;

    use std::string::{Self, String};

    /// A simple on-chain object holding a message.
    /// `has key` gives it a unique on-chain identity (Object ID).
    public struct Greeting has key {
        id: UID,
        message: String,
    }

    /// Pure function: returns a friendly greeting as a String.
    /// Demonstrates a simple, testable function with no side effects.
    public fun greet(): String {
        string::utf8(b"Hello, Move!")
    }

    /// Pure math function: adds two numbers. Easy to unit test.
    public fun add(a: u64, b: u64): u64 {
        a + b
    }

    /// ENTRY: Creates a new Greeting object and transfers it to the sender.
    /// - Creates a fresh UID using the transaction context
    /// - Stores the provided message
    /// - Transfers ownership to the transaction sender
    public fun create_greeting(message: String, ctx: &mut TxContext) {
        let g = Greeting { id: object::new(ctx), message };
        transfer::transfer(g, tx_context::sender(ctx));
    }

    /// ENTRY: Transfer an owned Greeting to another address.
    /// Consumes the Greeting object and moves it to `recipient`.
    public fun transfer_greeting(g: Greeting, recipient: address) {
        //TODO Transfer the Greeting obj to recipient
    }
