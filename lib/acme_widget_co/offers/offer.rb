# frozen_string_literal: true

module AcmeWidgetCo
  module Offers
    class Offer
      def discount(items:, catalogue:)
        raise NotImplementedError
      end
    end
  end
end
