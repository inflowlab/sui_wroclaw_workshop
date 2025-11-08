# 🧾 Capstone — Escrow / Marketplace Lite

Build a minimal marketplace on **Sui** where a **seller** lists an item, a **buyer** pays into **escrow** (in **SUI**), and the buyer **confirms delivery** to release funds to the seller.

## 🎯 Goals
- Practice **object modeling** with `has key` (`Listing`, `Escrow`).
- Work with **SUI coins** using `0x2::coin::Coin<0x2::sui::SUI>`.
- Implement **entry functions** for list → buy → confirm/refund.
- Emit **events**: `Listed`, `Purchased`, `Released`, `Refunded`.
- Guard flows with **error codes** and ownership checks.

---

## 📦 Project Layout
```
capstone-escrow-marketplace/
├─ Move.toml
├─ sources/
│  └─ marketplace.move
├─ tests/
│  └─ marketplace_tests.move   # scaffold (coins in tests vary by framework)
└─ scripts/
   └─ demo.md                  # CLI flow: seller + buyer
```

---

## 🛠 Build & Publish
```bash
sui move build
sui client publish --gas-budget 400000000
export PACKAGE_ID=<PACKAGE_ID_FROM_OUTPUT>     # PowerShell: $Env:PACKAGE_ID="..."
```

---

## 🧪 Demo Flow (CLI)

### 1) Seller lists an item
```bash
sui client call \
  --package $PACKAGE_ID \
  --module marketplace \
  --function create_listing \
  --args "Trezor Model T" 1000000000 \
  --gas-budget 200000000
```
Find your `Listing`:
```bash
sui client objects --owner $(sui client active-address) | grep Listing
export LISTING_ID=<0x...>
```

### 2) Buyer pays into escrow (with SUI)
- Ensure the **buyer account** has enough SUI (faucet/merge coins).  
- You can **split** a coin to exact price:
  ```bash
  sui client split-coin --coin-id <YOUR_COIN_ID> --amounts 1000000000 --gas-budget 200000000
  # use the returned new coin id as PAYMENT_COIN
  export PAYMENT_COIN=<0x...>
  ```

Now purchase:
```bash
sui client call \
  --package $PACKAGE_ID \
  --module marketplace \
  --function buy \
  --args $LISTING_ID $PAYMENT_COIN \
  --gas-budget 250000000
```
You’ll receive an `Escrow` object; change (if any) is returned to buyer automatically.

```bash
sui client objects --owner $(sui client active-address) | grep Escrow
export ESCROW_ID=<0x...>
```

### 3a) Buyer confirms delivery → release funds to seller
```bash
sui client call \
  --package $PACKAGE_ID \
  --module marketplace \
  --function confirm_delivery \
  --args $ESCROW_ID $LISTING_ID \
  --gas-budget 200000000
```

### 3b) (Alternative) Seller refunds buyer
```bash
sui client call \
  --package $PACKAGE_ID \
  --module marketplace \
  --function refund_buyer \
  --args $ESCROW_ID $LISTING_ID \
  --gas-budget 200000000
```

---

## 🧠 Design Notes
- `Listing` is owned by the **seller**. Setting `active=false` prevents double-sell.
- `buy` accepts **Coin<SUI>**. If the coin is larger than price, we split off `price` to escrow and return change to buyer.
- `Escrow` is owned by the **buyer** (safer UX). Only the buyer can **confirm**; only the seller can **refund**.
- On release/refund we **transfer** the escrowed coin to seller/buyer and **delete** the escrow object.
- We emit events for each lifecycle step.

---

## ❗ Troubleshooting
- **GasBudgetTooLow** → raise `--gas-budget` to 300–500M.
- **Object not found** → wrong ID or ownership changed after buy.
- **Coin too small** → split/merge coins first: `merge-coin` / `split-coin`.
- **Multiple coins** → after faucet, merge small coins to a single large coin before splits.