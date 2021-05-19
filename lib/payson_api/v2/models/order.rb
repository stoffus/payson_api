# frozen_string_literal: true

module PaysonAPI
  module V2
    module Models
      class Order
        attr_accessor :currency, :total_fee_excluding_tax, :total_fee_including_tax,
                      :total_price_excluding_tax, :total_price_including_tax, :total_tax_amount,
                      :total_credited_amount, :items

        def self.from_hash(hash)
          new.tap do |order|
            order.currency = hash['currency']
            order.total_fee_excluding_tax = hash['totalFeeExcludingTax']
            order.total_fee_including_tax = hash['totalFeeIncludingTax']
            order.total_price_excluding_tax = hash['totalPriceIncludingTax']
            order.total_price_including_tax = hash['totalPriceIncludingTax']
            order.total_tax_amount = hash['totalTaxAmount']
            order.total_credited_amount = hash['totalCreditedAmount']

            if hash['items']
              order.items = []
              hash['items'].each do |item|
                order.items << PaysonAPI::V2::Models::OrderItem.from_hash(item)
              end
            end
          end
        end
      end
    end
  end
end
