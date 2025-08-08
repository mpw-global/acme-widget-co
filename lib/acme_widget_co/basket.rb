# frozen_string_literal: true

require_relative 'money'

module AcmeWidgetCo
  class Basket
    def initialize(catalogue:, delivery_rule:, offers: [])
      @catalogue = catalogue
      @delivery_rule = delivery_rule
      @offers = offers
      @items = []
    end

    def add(code)
      @catalogue.fetch!(code)
      @items << code
      self
    end

    def items
      @items.dup
    end

    def subtotal
      @items.sum { |code| @catalogue.price_for(code) }
    end

    def discounts_total
      @offers.sum { |offer| offer.discount(items: @items, catalogue: @catalogue) }
    end

    def total_before_shipping
      subtotal - discounts_total
    end

    def shipping
      @delivery_rule.shipping_for(total_before_shipping)
    end

    def total
      Money.round(total_before_shipping + shipping)
    end

    def total_formatted
      Money.format(total)
    end
  end
end
