# 🧭 Patterns & Best Practices (60 min)

Focus:
- Capability pattern
- Events
- Basic access control
- Gas & gotchas

See `scripts/demo.md` for CLI walkthrough and `docs/gas_gotchas.md` for gas notes.

---

## ➕ Add-ons in this pack (advanced)

- **Witness pattern** (`witness.move`): issue a `Witness` (optionally via `AdminCap`) and require `&Witness` to mint a `Seal` object.
- **Fully-wired tests** (`tests/*.move`): positive/negative for capability, access control, witness, dynamic fields.

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


## Witness pattern (advanced)
```bash
# (Optional) Get AdminCap
sui client call \
  --package $PACKAGE_ID \
  --module witness \
  --function init \
  --gas-budget 200000000

# In tests we use new_witness_for_test(); for CLI, prefer handing capabilities as objects.
```

## Dynamic fields (attributes)
```bash
sui client call \
  --package $PACKAGE_ID \
  --module dynamic_fields \
  --function create \
  --gas-budget 200000000

sui client objects --owner $(sui client active-address) | grep Profile
export PROFILE_ID=<...>

sui client call \
  --package $PACKAGE_ID \
  --module dynamic_fields \
  --function set_attr \
  --args $PROFILE_ID "color" "blue" \
  --gas-budget 200000000
```

