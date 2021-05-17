module PaysonAPI
  module V2
    module Models
      class Checkout
        attr_accessor :id, :status, :expiration_time, :description, :snippet,
          :customer, :order, :merchant

        def self.from_json(json)
          self.new.tap do |checkout|
            checkout.id = json['id']
            checkout.status = json['status']
            checkout.expiration_time = json['expirationTime']
            checkout.description = json['description']
            checkout.snippet = json['snippet']

            if json['customer']
              checkout.customer = PaysonAPI::V2::Models::Customer.from_json(json['customer'])
            end

            if json['merchant']
              checkout.merchant = PaysonAPI::V2::Models::Merchant.from_json(json['merchant'])
            end

            checkout.order = PaysonAPI::V2::Models::Order.from_json(json['order'])
          end
        end
      end
    end
  end
end
