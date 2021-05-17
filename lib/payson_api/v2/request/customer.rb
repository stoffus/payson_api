# frozen_string_literal: true

module PaysonAPI
  module V2
    module Request
      class Customer
        attr_accessor :email, :first_name, :last_name, :city, :zip, :street, :identity_number

        def to_hash
          {}.tap do |hash|
            hash['email'] = @email
            hash['firstName'] = @first_name
            hash['lastName'] = @last_name
            hash['identityNumber'] = @identity_number
            hash['postalCode'] = @zip
            hash['street'] = @street
            hash['city'] = @city
          end
        end
      end
    end
  end
end
