# 🧭 Patterns & Best Practices (60 min)

Focus:
- Capability pattern
- Events
- Basic access control

---

## ➕ Add-ons in this pack (advanced)

- **Fully-wired tests** (`tests/*.move`): positive/negative for capability, access control, .

Run all tests:
```bash
sui move test
```

## Build & Publish
```bash
sui move build
sui client publish --gas-budget 300000000
export PACKAGE_ID=<PACKAGE_ID>
```

## Capability pattern
```bash
sui client call \
  --package $PACKAGE_ID \
  --module capability \
  --function init \
  --gas-budget 200000000

# Mint via capability (CLI auto-borrows &AdminCap you own)
sui client call \
  --package $PACKAGE_ID \
  --module capability \
  --function mint_badge \
  --args <ADMINCAP_ID> "VIP" 1 $(sui client active-address) \
  --gas-budget 200000000
```

## Events
```bash
sui client call \
  --package $PACKAGE_ID \
  --module events \
  --function mint \
  --args "Member" \
  --gas-budget 200000000

sui client objects --owner $(sui client active-address) | grep Badge
export BADGE_ID=<...>

sui client call \
  --package $PACKAGE_ID \
  --module events \
  --function rename \
  --args $BADGE_ID "Gold Member" \
  --gas-budget 200000000
```

## Access control
```bash
sui client call \
  --package $PACKAGE_ID \
  --module access_control \
  --function create \
  --args "hello" \
  --gas-budget 200000000

sui client objects --owner $(sui client active-address) | grep Notebook
export NOTE_ID=<...>

sui client call \
  --package $PACKAGE_ID \
  --module access_control \
  --function append_line \
  --args $NOTE_ID "world" \
  --gas-budget 200000000
```
