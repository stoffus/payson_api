# frozen_string_literal: true

module PaysonAPI
  module V2
    module Requests
      class UpdateCheckout
        attr_accessor :id, :status, :locale, :currency, :order, :customer, :merchant, :description

        def initialize
          @order = PaysonAPI::V2::Requests::Order.new
          @merchant = PaysonAPI::V2::Requests::Merchant.new
        end

        def to_hash
          {}.tap do |hash|
            hash['id'] = @id
            hash['order'] = @order.to_hash
            hash['status'] = @status
            hash['merchant'] = @merchant.to_hash
          end
        end
      end
    end
  end
end
