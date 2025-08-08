# Acme Widget Co

## Requirements
- Ruby 3.x
- Bundler

## Setup
```bash
bundle install
```

## Run examples

```bash
# prints the total formatted with a leading $
./bin/demo B01 G01
./bin/demo R01 R01
./bin/demo R01 G01
./bin/demo B01 B01 R01 R01 R01
```

## Test

```bash
bundle exec rspec
```

## Design

- Dependency injection for catalogue, delivery rule, and offers.
- Strategy interfaces: `Delivery::TieredRule` and `Offers::Offer`.
- Money via `BigDecimal` with `ROUND_HALF_UP`.
- Discount rounding per pair to match the provided totals; shipping applied on the post-discount subtotal.

## Extending

- Add new offer strategies under `lib/acme_widget_co/offers/` implementing `#discount(items:, catalogue:)`.
- Add alternate delivery strategies under `lib/acme_widget_co/delivery/` implementing `#shipping_for(total_after_discounts)`.

## Assumptions

- Delivery bands compare against the total after discounts.
- The red-widget offer applies per pair: floor(n/2) * (unit/2), rounded to two decimals per pair.
