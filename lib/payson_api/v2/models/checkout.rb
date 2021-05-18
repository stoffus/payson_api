# frozen_string_literal: true

module PaysonAPI
  module V2
    module Models
      class Checkout
        attr_accessor :id, :status, :expiration_time, :description, :snippet,
                      :customer, :order, :merchant

        def self.from_hash(hash)
          new.tap do |checkout|
            checkout.id = hash['id']
            checkout.status = hash['status']
            checkout.expiration_time = hash['expirationTime']
            checkout.description = hash['description']
            checkout.snippet = hash['snippet']

            checkout.customer = PaysonAPI::V2::Models::Customer.from_hash(hash['customer']) if hash['customer']

            checkout.merchant = PaysonAPI::V2::Models::Merchant.from_hash(hash['merchant']) if hash['merchant']

            checkout.order = PaysonAPI::V2::Models::Order.from_hash(hash['order'])
          end
        end
      end
    end
  end
end
