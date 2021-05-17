# frozen_string_literal: true

module PaysonAPI
  module V2
    module Request
      class OrderItem
        attr_accessor :name, :quantity, :unit_price, :ean, :tax_rate, :reference,
          :discount_rate, :image_uri, :type, :uri

        def to_hash
          {}.tap do |hash|
            hash['name'] = @name
            hash['quantity'] = @quantity
            hash['unitPrice'] = @unit_price
            hash['ean'] = @ean unless @ean.nil?
            hash['taxRate'] = @tax_rate unless @tax_rate.nil?
            hash['reference'] = @reference unless @reference.nil? 
            hash['discountRate'] = @discount_rate unless @discount_rate.nil?
            hash['imageUri'] = @image_uri unless @image_uri.nil?
            hash['type'] = @type unless @type.nil?
            hash['uri'] = @uri unless @uri.nil?
          end
        end
      end
    end
  end
end
