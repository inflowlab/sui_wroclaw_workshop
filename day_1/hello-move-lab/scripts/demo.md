# Demo script — Hello Move (Devnet)

## Build
```bash
sui move build
```

## Test
```bash
sui move test
```

## Publish
```bash
sui client publish --gas-budget 20000000
```
Save `PACKAGE_ID` from the output.

## Call entry to create object
```bash
sui client call \
  --package $PACKAGE_ID \
  --module hello \
  --function create_greeting \
  --args "Hello from CLI" \
  --gas-budget 20000000
```

## Inspect objects
```bash
sui client objects --owner $(sui client active-address)
```
