# frozen_string_literal: true

module PaysonAPI
  module V2
    module Models
      class Checkout
        attr_accessor :id, :status, :expiration_time, :description, :snippet,
          :customer, :order, :merchant

        def self.from_hash(hash)
          self.new.tap do |checkout|
            checkout.id = hash['id']
            checkout.status = hash['status']
            checkout.expiration_time = hash['expirationTime']
            checkout.description = hash['description']
            checkout.snippet = hash['snippet']

            if hash['customer']
              checkout.customer = PaysonAPI::V2::Models::Customer.from_hash(hash['customer'])
            end

            if hash['merchant']
              checkout.merchant = PaysonAPI::V2::Models::Merchant.from_hash(hash['merchant'])
            end

            checkout.order = PaysonAPI::V2::Models::Order.from_hash(hash['order'])
          end
        end
      end
    end
  end
end
