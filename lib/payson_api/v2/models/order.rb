# frozen_string_literal: true

module PaysonAPI
  module V2
    module Models
      class Order
        attr_accessor :currency, :total_fee_excluding_tax, :total_fee_including_tax,
          :total_price_excluding_tax, :total_price_including_tax, :total_tax_amount,
          :total_credited_amount, :items

        def self.from_json(json)
          self.new.tap do |order|
            order.currency = json['currency']
            order.total_fee_excluding_tax = json['totalFeeExcludingTax']
            order.total_fee_including_tax = json['totalFeeIncludingTax']
            order.total_price_excluding_tax = json['totalPriceIncludingTax']
            order.total_price_including_tax = json['totalPriceIncludingTax']
            order.total_tax_amount = json['totalTaxAmount']
            order.total_credited_amount = json['totalCreditedAmount']

            if json['items']
              order.items = []
              json['items'].each do |item|
                order.items << PaysonAPI::V2::Models::OrderItem.from_json(item)
              end
            end
          end
        end
      end
    end
  end
end
