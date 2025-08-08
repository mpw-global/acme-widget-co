# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'

module AcmeWidgetCo
  module Money
    SCALE = 2
    MODE  = BigDecimal::ROUND_HALF_UP

    def self.bd(val)
      case val
      when BigDecimal then val
      when String     then BigDecimal(val)
      when Numeric    then BigDecimal(val.to_s)
      else raise ArgumentError, "Unsupported money value: #{val.inspect}"
      end
    end

    def self.round(val)
      bd(val).round(SCALE, MODE)
    end

    def self.format(val)
      Kernel.format('$%.2f', round(val))
    end
  end
end
