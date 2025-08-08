# frozen_string_literal: true

require_relative 'product'
require_relative 'money'

module AcmeWidgetCo
  class Catalogue
    def initialize(products: [])
      @by_code = {}
      products.each { |p| add(p) }
    end

    def add(product)
      @by_code[product.code] = product
    end

    def fetch!(code)
      @by_code.fetch(code) { raise KeyError, "Unknown product code: #{code}" }
    end

    def price_for(code)
      Money.bd(fetch!(code).price)
    end
  end
end
