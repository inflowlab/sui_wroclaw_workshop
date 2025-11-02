# 🧪 Lab #2 — My First Object (Counter)

Build your first **Sui object**: a counter that only the **owner** can mutate.

## 🎯 You will
- Create a `Counter` object (owner = creator)
- Increment it (owner‑only)
- (Optional) Reset it (owner‑only)
- Transfer it
- Run unit tests (including expected failures)

Estimated time: **45–60 minutes**. Devnet assumed.

---

## 📦 Project layout
```
my-first-object-counter/
├─ Move.toml
├─ sources/
│  └─ counter.move
└─ tests/
   └─ counter_tests.move    # scaffold with TODOs for students
```

---

## 🛠 Build & Test
```bash
sui move build
sui move test
```

---

## 🚀 Publish to Devnet
```bash
sui client publish --gas-budget 200000000
```
Copy the `PACKAGE_ID` from the output.

**macOS/bash**
```bash
export PACKAGE_ID=<PACKAGE_ID_FROM_OUTPUT>
```

**Windows PowerShell**
```powershell
$Env:PACKAGE_ID="<PACKAGE_ID_FROM_OUTPUT>"
```

---

## 🧭 CLI Demo

### 1) Create a counter (owned by you)
```bash
sui client call   --package $PACKAGE_ID   --module counter   --function create_counter   --gas-budget 200000000
```

Find your Counter object:
```bash
sui client objects --owner $(sui client active-address) | grep Counter
# export COUNTER_ID=0x...
```

### 2) Increment (owner‑only)
```bash
sui client call   --package $PACKAGE_ID   --module counter   --function increment   --args $COUNTER_ID   --gas-budget 200000000
```

### 3) (Optional) Reset to zero (owner‑only)
```bash
sui client call   --package $PACKAGE_ID   --module counter   --function reset   --args $COUNTER_ID   --gas-budget 200000000
```

### 4) Transfer to another address
```bash
sui client call   --package $PACKAGE_ID   --module counter   --function transfer_counter   --args $COUNTER_ID <RECIPIENT_ADDRESS>   --gas-budget 200000000
```

Verify owner changed:
```bash
sui client object --id $COUNTER_ID
```

---

## 🧠 Rules enforced in code
- Only **owner** can mutate (`ERR_NOT_OWNER = 1`)
- Values are `u64`, wrapping not allowed (asserts on overflow in tests if added)

---

## 🛟 Troubleshooting
- **Object not found** → check `COUNTER_ID`
- **GasBudgetTooLow** → increase `--gas-budget`
- **Error code 1** → you’re not the owner

Good luck! 💪
