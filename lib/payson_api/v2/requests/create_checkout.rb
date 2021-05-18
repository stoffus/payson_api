# frozen_string_literal: true

module PaysonAPI
  module V2
    module Requests
      class CreateCheckout
        attr_accessor :expiration_time, :description, :customer, :order, :merchant, :gui

        def initialize
          @order = PaysonAPI::V2::Requests::Order.new
          @merchant = PaysonAPI::V2::Requests::Merchant.new
        end

        def to_hash
          {}.tap do |hash|
            hash['order'] = @order.to_hash
            hash['merchant'] = @merchant.to_hash
            hash['description'] = @description unless @description.nil?
            hash['expirationTime'] = @expiration_time unless @expiration_time.nil?
            hash['customer'] = @customer.to_hash unless @customer.nil?
          end
        end
      end
    end
  end
end
