# frozen_string_literal: true

require 'cgi'

module PaysonAPI
  module V1
    class ShippingAddress
      FORMAT_STRING = 'shippingAddress.%s'
      attr_accessor :name, :street_address, :postal_code, :city, :country

      def to_hash
        {}.tap do |hash|
          hash[FORMAT_STRING % 'name'] = @name
          hash[FORMAT_STRING % 'streetAddress'] = @street_address
          hash[FORMAT_STRING % 'postalCode'] = @postal_code
          hash[FORMAT_STRING % 'city'] = @city
          hash[FORMAT_STRING % 'country'] = @country
        end
      end

      def self.parse(data)
        return unless data[FORMAT_STRING % 'name']

        new.tap do |s|
          s.name = CGI.unescape(data[FORMAT_STRING % 'name'].to_s)
          s.street_address = CGI.unescape(data[FORMAT_STRING % 'streetAddress'].to_s)
          s.postal_code = CGI.unescape(data[FORMAT_STRING % 'postalCode'].to_s)
          s.city = CGI.unescape(data[FORMAT_STRING % 'city'].to_s)
          s.country = CGI.unescape(data[FORMAT_STRING % 'country'].to_s)
        end
      end
    end
  end
end
