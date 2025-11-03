# 🧭 Sui Move Workshop — Final Plan

This two-day workshop gives participants a practical, end-to-end introduction to the **Sui blockchain** and the **Move language**.  
Students will learn Sui’s object model, Move programming patterns, and real-world development workflows by building, testing, and deploying small Move modules on **Devnet**.

---

## 🧱 Day 1 — *Hello Move Lab*
**Directory:** `hello-move-lab/`  
**README:** *First hands-on with Sui Move: build, test, publish to Devnet, create and inspect objects.*

### 🎯 Goal
Get comfortable with the Move development environment, understand the Sui object lifecycle, and learn how to build and publish a simple Move package.

### 🕒 Activities
- Verify Sui CLI setup, switch to Devnet, get gas from faucet.  
- Review Sui object model vs. EVM accounts.  
- Learn Move basics: modules, structs, functions, abilities, and entry functions.  
- Build and test a minimal Move module (“Hello Move”).  
- Publish the package and inspect created objects.  

---

## 🧩 Day 2 — *Unit Testing Patterns*
**Directory:** `unit-testing-patterns/`  
**README:** *Unit and scenario tests, expected failures, and guarding invariants.*

### 🎯 Goal
Learn how to test Move code effectively, ensuring correctness and handling failure cases.

### 🕒 Activities
- Understand `#[test]` and `#[expected_failure]` annotations.  
- Write positive and negative unit tests.  
- Use `sui::test_scenario` to simulate transactions and object ownership.  
- Practice verifying error codes and guarding invariants with `assert!`.  

---

## 🧱 Day 2 — *Sui Move Objects Demo*
**Directory:** `sui-move-objects-demo/`  
**README:** *Create/update/transfer an Item object, observe events, and practice CLI flows.*

### 🎯 Goal
Explore Sui’s **object model** in action. Create, update, and transfer custom objects while emitting and inspecting on-chain events.

### 🕒 Activities
- Build a Move module defining an `Item` object (`has key`).  
- Mint and transfer objects via CLI calls.  
- Emit and inspect events (`event::emit`).  
- Understand object ownership: owned, shared, immutable.  

---

## 🔢 Day 2 — *My First Object (Counter)*
**Directory:** `my-first-object-counter/`  
**README:** *Build a Counter object with owner-only mutation; increment/reset/transfer; run unit tests.*

### 🎯 Goal
Practice secure state mutation and ownership patterns by creating a simple **Counter object**.

### 🕒 Activities
- Create a `Counter` object (`has key`).  
- Implement `increment`, `reset`, and `transfer` entry functions.  
- Restrict mutation to the object’s owner.  
- Add unit tests to cover positive and failure scenarios.  

---

## 🧭 Day 2 — *Patterns & Best Practices*
**Directory:** `patterns-best-practices/`  
**README:** *Capability pattern, events, basic access control, gas gotchas; includes witness and dynamic fields.*

### 🎯 Goal
Learn common Move design patterns and Sui-specific idioms used in production-grade smart contracts.

### 🕒 Activities
- Implement and analyze **capability** and **access control** patterns.  
- Work with **events**, **gas budgets**, and **ownership** safely.  
- Explore **witness** and **dynamic fields** for composable data structures.  
- Understand how to avoid common pitfalls in Move/Sui development.  

---

## 💼 Capstone (Optional Extension)
**Project:** *Escrow / Marketplace Lite*  
Combine all learned skills into a working minimal marketplace where:
- The seller lists an item.
- The buyer deposits into escrow.
- Funds are released when the buyer confirms delivery.

---

## 🧩 Workshop Flow Summary

| Day | Topic | Duration | Key Deliverables |
|-----|--------|-----------|------------------|
| 1 | Hello Move Lab | 2h | Build + publish simple module |
| 2 | Unit Testing Patterns | 45m | Write and run tests |
| 2 | Sui Move Objects Demo | 45m | Create, transfer, inspect objects |
| 2 | My First Object (Counter) | 1h | Implement owner-only mutation |
| 2 | Patterns & Best Practices | 45m | Learn common patterns |
| 2 | Capstone: Escrow / Marketplace | 2.5h | Build and demo mini project |

---

✅ **Outcome:** Participants leave with hands-on experience building, testing, and deploying Move modules on Sui, along with reusable code patterns for production smart contracts.
