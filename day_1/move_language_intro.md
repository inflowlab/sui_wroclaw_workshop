# 🧮 Move Language Introduction

> Duration: ~30–40 minutes  
> Goal: Learn the **core syntax and building blocks** of the Move language used on Sui — modules, structs, functions, abilities, and entry functions.

---

## 🧠 1️⃣ What is Move?

Move is a **safe, resource-oriented programming language** designed for **digital assets and smart contracts**.  
It was originally developed for Facebook’s **Diem** blockchain and later adopted by **Sui** and **Aptos**.

Move’s key ideas:
- **Resources can’t be copied or lost accidentally.**
- **Type system enforces safety.**
- **Ownership and permissions are explicit.**

---

## 🧩 2️⃣ Basic Building Blocks

Move code lives inside **modules**.

Each module defines **types (structs)** and **functions** that manipulate them.

```move
module my_app::hello {
    public fun greet(): u64 {
        42
    }
}
```

- `my_app` is the package name (declared in `Move.toml`)
- `hello` is the module name
- Functions can be `public` or `public(entry)`

---

## 🏗️ 3️⃣ Structs — Custom Data Types

- A `struct` defines a custom type with named fields. It’s the core way to model assets and other data in Move. 
move-book.com
- Default behavior: structs are linear and ephemeral → by default they cannot be copied, dropped, or stored; you must move/handle them explicitly. Abilities relax these restrictions
- Fields can be any non-reference type, including other structs. Recursive structs are not allowed (a struct can’t contain itself).
- Struct types can only be created ("packed"), destroyed ("unpacked") inside the module that defines the struct.
- The fields of a struct are only accessible inside the module that defines the struct.

```move
public struct Counter has key {
    id: UID,
    value: u64
}
```

- `id: UID` → makes it a **Sui object** (unique identity)
- `value: u64` → simple integer field
- `has key` → gives it **object identity** on-chain


### Example: a plain struct (no key)
```move
public struct Point has copy, drop {
    x: u64,
    y: u64,
}
```

- Can be **copied** and **dropped** freely (unlike resources).

---

## 🧱 4️⃣ Abilities — What a Type Can Do

Abilities are **permissions** that control how values can be used.
If you don’t declare an ability, you don’t have it; the compiler enforces this at type-check time.

| Ability | Meaning | Example |
|----------|----------|----------|
| **copy** | Can be duplicated | numbers, strings |
| **drop** | Can be discarded at end of scope | temporary data |
| **store** | Can be stored inside another struct or global storage | persistent fields |
| **key** | Gives global identity (used for objects) for storage/lookup (Sui uses this for objects) | Sui objects |


On Sui, a struct with key is an object type and must have its first field exactly id: UID. This gives the object a unique on-chain identity. Also, fields of an object must satisfy ability rules (e.g., embedded types need store).
**Example:**

```move
public struct Coin has store, key {
    id: UID,
    balance: u64
}
```

Without proper abilities, certain operations (like storing inside another object) will fail at compile time.

### Usage Patterns
- **Asset/resource modeling:** Use default (no copy, no drop) or omit copy/drop to force linear handling. This is ideal for tokens, NFTs, tickets.

- **Utility/value types:** Add copy, drop for lightweight data (e.g., points, small config).

- **Composable state:** Nest structs; to embed a type inside an object (has key), the embedded type must have store. 

- **Sui objects:** Model user-owned state as `struct X has key { id: UID, ... }`; create with object::new, transfer with transfer::transfer.

### Rules & Gotchas
- **Defaults are strict:** Without abilities, a struct **can’t be copied, dropped, or stored**. Handle/move it explicitly or add abilities. 

- **Non-recursive:** You can’t define a struct that contains itself (directly or indirectly via the same type). 

- **Embedding inside objects:** If `Foo has key` contains field `bar: Bar`, then `Bar` must have `store`. 

- **Sui object rule:** If `has key` on Sui, first field must be `id: UID` (verifier enforces uniqueness); no object can have `copy/drop` because `UID` lacks them. 

- **Abilities are checked transitively:** If you store type `T` inside another, `T` must have the abilities required by the context (notably `store`).
---

## ⚙️ 5️⃣ Functions

Functions are declared with `fun` and can be:
- **private (default)** – visible only in the same module
- **public** – visible to other modules
- **public(entry)** – callable as a **transaction entry point**

### Example

```move
module my_app::math {
    public fun add(a: u64, b: u64): u64 {
        a + b
    }

    fun double(x: u64): u64 {
        2 * x
    }
}
```

### Calling from another module
```move
use my_app::math;
let result = math::add(5, 10);
```

---

## 🚪 6️⃣ Entry Functions

**Entry functions** are transaction entry points.  
They are invoked directly by users through the **Sui CLI**.

```move
module counter_app::counter {
    use sui::object;
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    struct Counter has key {
        id: UID,
        value: u64,
    }

    public entry fun create_counter(ctx: &mut TxContext) {
        let counter = Counter { id: object::new(ctx), value: 0 };
        transfer::transfer(counter, tx_context::sender(ctx));
    }

    public entry fun increment(counter: &mut Counter) {
        counter.value = counter.value + 1;
    }
}
```

Explanation:
- `entry` → means callable via `sui client call`
- `TxContext` → built-in object that provides transaction info (sender, IDs, gas)
- `object::new(ctx)` → creates a new unique object ID
- `transfer::transfer` → moves ownership to a specific address

---

## 🧩 7️⃣ Entry Function Example — Using CLI

Once built and published, you can call the function via:

```bash
sui client call   --package <PACKAGE_ID>   --module counter   --function create_counter   --gas-budget 10000000
```

Then increment the counter:
```bash
sui client call   --package <PACKAGE_ID>   --module counter   --function increment   --args <COUNTER_OBJECT_ID>   --gas-budget 10000000
```

---

## 🧮 8️⃣ Summary

✅ **Modules** group related structs and functions.  
✅ **Structs** define data types and objects.  
✅ **Abilities** restrict what types can do (copy, drop, store, key).  
✅ **Functions** define logic — private, public, or entry.  
✅ **Entry functions** are transaction endpoints callable from CLI.  

---

## 💬 Discussion Prompts

- Why do you think Move forbids copying most structs?  
- Which ability combination would you use for a temporary counter inside another struct?  
- What’s the difference between `public` and `public(entry)`?

---

## 🚀 Next Step

Proceed to **Lab #1 – “Hello Move”**  
You’ll write your own module, run tests, and publish your first package to Devnet.
