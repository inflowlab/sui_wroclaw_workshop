# 🧱 Sui Move with Objects — Demo Pack

**Goal (45–60 min):** Learn how to **create** and **transfer** Sui objects, **emit events**, and run everything from the **CLI**.

## What you’ll do
- Create an `Item` object with a name
- Update the item (mutate owned object)
- Transfer the item to another address
- Observe **events** for create/update/transfer in transaction effects
- Practice CLI: `publish`, `call`, `objects`, `object`

> Works on Windows & macOS, Devnet assumed (`sui client switch --env devnet`).

---

## Project layout
```
sui-move-objects-demo/
├─ Move.toml
├─ sources/
│  └─ objects_demo.move
└─ tests/
   └─ objects_demo_tests.move
```

---

## Build & Test
```bash
sui move build
sui move test
```

Expected: 0 failures.

---

## Publish to Devnet
```bash
sui client publish --gas-budget 200000000
```
Copy the `PACKAGE_ID` from the output. Set it:

**macOS / bash**
```bash
export PACKAGE_ID=<PACKAGE_ID_FROM_OUTPUT>
```

**Windows PowerShell**
```powershell
$Env:PACKAGE_ID="<PACKAGE_ID_FROM_OUTPUT>"
```

---

## CLI: Create, Update, Transfer

### 1) Create an Item (emits `Created` event)
```bash
sui client call   --package $PACKAGE_ID   --module objects_demo   --function create_item   --args "Sword"   --gas-budget 200000000
```
Find the new `Item` object ID:
```bash
sui client objects $(sui client active-address) | grep Item
# ITEM_ID=0x...
```

### 2) Update the Item (emits `Updated` event)
```bash
sui client call   --package $PACKAGE_ID   --module objects_demo   --function rename_item   --args $ITEM_ID "Excalibur"   --gas-budget 200000000
```

### 3) Transfer the Item (emits `Transferred` event)
Replace `<RECIPIENT>` with an address you control (or a neighbor in class).

```bash
sui client call   --package $PACKAGE_ID   --module objects_demo   --function transfer_item   --args $ITEM_ID <RECIPIENT>   --gas-budget 200000000
```

Verify new owner:
```bash
sui client object --id $ITEM_ID
```

---

## Where to see events?
Events appear in the **transaction effects** of the CLI output (search for `Created`, `Updated`, `Transferred`). Some explorers also index events on Devnet; CLI output is enough for this demo.

---

## Troubleshooting
- **GasBudgetTooLow** → bump `--gas-budget` (e.g., `400000000`)
- **Object not found** → double-check `ITEM_ID` and ownership; re-run previous step
- **Faucet 429** → wait 60s and retry `sui client faucet`

---
