# Demo — Escrow / Marketplace Lite (Devnet)

## Build & Publish
```bash
sui move build
sui client publish --gas-budget 400000000
export PACKAGE_ID=<PACKAGE_ID_FROM_OUTPUT>
```

## Seller: create listing
```bash
sui client call \
  --package $PACKAGE_ID \
  --module marketplace \
  --function create_listing \
  --args "Trezor Model T" 1000000000 \
  --gas-budget 250000000
```
Find listing ID:
```bash
sui client objects --owner $(sui client active-address) | grep Listing
export LISTING_ID=<0x...>
```

## Buyer: prepare payment coin
Split exact price from a big SUI coin:
```bash
sui client coins --owner $(sui client active-address) | head
sui client split-coin --coin-id <COIN_ID> --amounts 1000000000 --gas-budget 200000000
export PAYMENT_COIN=<0x_NEW_COIN>
```

## Buyer: buy (escrow)
```bash
sui client call \
  --package $PACKAGE_ID \
  --module marketplace \
  --function buy \
  --args $LISTING_ID $PAYMENT_COIN \
  --gas-budget 300000000
```
After buy, you receive an Escrow object:
```bash
sui client objects --owner $(sui client active-address) | grep Escrow
export ESCROW_ID=<0x...>
```

## Buyer: confirm delivery (release to seller)
```bash
sui client call \
  --package $PACKAGE_ID \
  --module marketplace \
  --function confirm_delivery \
  --args $ESCROW_ID $LISTING_ID \
  --gas-budget 250000000
```

## (Alternative) Seller: refund buyer
```bash
sui client call \
  --package $PACKAGE_ID \
  --module marketplace \
  --function refund_buyer \
  --args $ESCROW_ID $LISTING_ID \
  --gas-budget 250000000
```