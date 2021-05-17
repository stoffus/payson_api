# frozen_string_literal: true

module PaysonAPI
  module V2
    module Models
      class Customer
        attr_accessor :city, :country_code, :identity_number, :email, :first_name,
          :last_name, :phone, :postal_code, :street, :type

        def self.from_json(json)
          self.new.tap do |customer| 
            customer.city = json['city']
            customer.country_code = json['countryCode']
            customer.first_name = json['firstName']
            customer.last_name = json['lastName']
            customer.identity_number = json['identityNumber']
            customer.email = json['email']
            customer.postal_code = json['postalCode']
            customer.phone = json['phone']
            customer.street = json['street']
            customer.type = json['type']
          end
        end
      end
    end
  end
end
