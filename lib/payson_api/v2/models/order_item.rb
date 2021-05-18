# frozen_string_literal: true

module PaysonAPI
  module V2
    module Models
      class OrderItem
        attr_accessor :item_id, :discount_rate, :ean, :image_uri, :name, :quantity,
                      :reference, :tax_rate, :total_price_excluding_tax, :total_price_including_tax,
                      :total_tax_amount, :credited_amount, :type, :unit_price, :uri

        def self.from_hash(hash)
          new.tap do |item|
            item.item_id = hash['itemId']
            item.discount_rate = hash['discountRate']
            item.ean = hash['ean']
            item.image_uri = hash['imageUri']
            item.name = hash['name']
            item.quantity = hash['quantity']
            item.reference = hash['reference']
            item.tax_rate = hash['taxRate']
            item.total_price_excluding_tax = hash['totalPriceExcludingTax']
            item.total_price_including_tax = hash['totalPriceIncludingTax']
            item.total_tax_amount = hash['totalTaxAmount']
            item.credited_amount = hash['creditedAmount']
            item.type = hash['type']
            item.unit_price = hash['unitPrice']
            item.uri = hash['uri']
          end
        end
      end
    end
  end
end
