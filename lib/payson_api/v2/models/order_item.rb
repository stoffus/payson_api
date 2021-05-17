# frozen_string_literal: true

module PaysonAPI
  module V2
    module Models
      class OrderItem
        attr_accessor :item_id, :discount_rate, :ean, :image_uri, :name, :quantity,
          :reference, :tax_rate, :total_price_excluding_tax, :total_price_including_tax,
          :total_tax_amount, :credited_amount, :type, :unit_price, :uri

        def self.from_json(json)
          self.new.tap do |item|
            item.item_id = json['itemId']
            item.discount_rate = json['discountRate']
            item.ean = json['ean']
            item.image_uri = json['imageUri']
            item.name = json['name']
            item.quantity = json['quantity']
            item.reference = json['reference']
            item.tax_rate = json['taxRate']
            item.total_price_excluding_tax = json['totalPriceExcludingTax']
            item.total_price_including_tax = json['totalPriceIncludingTax']
            item.total_tax_amount = json['totalTaxAmount']
            item.credited_amount = json['creditedAmount']
            item.type = json['type']
            item.unit_price = json['unitPrice']
            item.uri = json['uri']
          end
        end
      end
    end
  end
end
