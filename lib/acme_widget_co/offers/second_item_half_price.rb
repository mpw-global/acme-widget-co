# frozen_string_literal: true

require_relative '../money'

module AcmeWidgetCo
  module Offers
    # "Buy one X, get the second half price" per pair
    class SecondItemHalfPrice < Offer
      def initialize(product_code:)
        @product_code = product_code
      end

      def discount(items:, catalogue:)
        count = items.count(@product_code)
        return 0.to_d if count < 2

        pairs = count / 2
        unit   = catalogue.price_for(@product_code)
        per_pair_discount = Money.round(unit / 2)
        Money.bd(pairs) * per_pair_discount
      end
    end
  end
end