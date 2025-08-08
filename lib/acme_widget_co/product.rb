# frozen_string_literal: true

module AcmeWidgetCo
  Product = Struct.new(:code, :name, :price, keyword_init: true)
end
