# frozen_string_literal: true

module PaysonAPI
  module V2
    module Requests
      class Order
        attr_accessor :currency, :items

        def initialize
          @items = []
        end

        def to_hash
          {}.tap do |hash|
            hash['currency'] = @currency
            hash['items'] = @items.map(&:to_hash)
          end
        end
      end
    end
  end
end
