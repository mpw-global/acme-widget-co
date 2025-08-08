# frozen_string_literal: true

require_relative '../money'

module AcmeWidgetCo
  module Delivery
    # Tiers are evaluated in order; first threshold greater than total applies.
    # Example: [{lt: 50, cost: 4.95}, {lt: 90, cost: 2.95}], else 0
    class TieredRule
      def initialize(bands: [], else_cost: 0)
        @bands = bands.map { |b| { lt: Money.bd(b[:lt]), cost: Money.bd(b[:cost]) } }
        @else_cost = Money.bd(else_cost)
      end

      def shipping_for(total_after_discounts)
        t = Money.bd(total_after_discounts)
        band = @bands.find { |b| t < b[:lt] }
        cost = band ? band[:cost] : @else_cost
        Money.round(cost)
      end
    end
  end
end
