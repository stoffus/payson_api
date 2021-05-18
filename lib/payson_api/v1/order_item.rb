# frozen_string_literal: true

require 'cgi'

module PaysonAPI
  module V1
    class OrderItem
      attr_accessor :description, :quantity, :unit_price, :sku, :tax
      FORMAT_STRING = "orderItemList.orderItem(%d).%s"

      def self.to_hash(order_items)
        {}.tap do |hash|
          order_items.each_with_index do |item, index|
            hash.merge!({
              FORMAT_STRING % [index, 'description'] => item.description,
              FORMAT_STRING % [index, 'unitPrice'] => item.unit_price,
              FORMAT_STRING % [index, 'quantity'] => item.quantity,
              FORMAT_STRING % [index, 'taxPercentage'] => item.tax,
              FORMAT_STRING % [index, 'sku'] => item.sku
            })
          end
        end
      end

      def self.parse(data)
        [].tap do |order_items|
          i = 0
          while data[FORMAT_STRING % [i, 'description']]
            order_items << self.new.tap do |item|
              item.description = CGI.unescape(data[FORMAT_STRING % [i, 'description']].to_s)
              item.unit_price = data[FORMAT_STRING % [i, 'unitPrice']]
              item.quantity = data[FORMAT_STRING % [i, 'quantity']]
              item.tax = data[FORMAT_STRING % [i, 'taxPercentage']]
              item.sku = data[FORMAT_STRING % [i, 'sku']]
            end
            i += 1
          end
        end
      end
    end
  end
end
