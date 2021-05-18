# frozen_string_literal: true

module PaysonAPI
  module V2
    module Models
      class Customer
        attr_accessor :city, :country_code, :identity_number, :email, :first_name,
                      :last_name, :phone, :postal_code, :street, :type

        def self.from_hash(hash)
          new.tap do |customer|
            customer.city = hash['city']
            customer.country_code = hash['countryCode']
            customer.first_name = hash['firstName']
            customer.last_name = hash['lastName']
            customer.identity_number = hash['identityNumber']
            customer.email = hash['email']
            customer.postal_code = hash['postalCode']
            customer.phone = hash['phone']
            customer.street = hash['street']
            customer.type = hash['type']
          end
        end
      end
    end
  end
end
