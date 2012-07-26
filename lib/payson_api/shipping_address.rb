require 'cgi'

module PaysonAPI
class ShippingAddress
  FORMAT_STRING = "shippingAddress.%s"
  attr_accessor :name, :street_address, :postal_code, :city, :country

  def initialize(name, street_address, postal_code, city, country)
    @name = name
    @street_address = street_address
    @postal_code = postal_code
    @city = city
    @country = country
  end

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
    name = CGI.unescape(data[FORMAT_STRING % 'name'])
    street_address = CGI.unescape(data[FORMAT_STRING % 'streetAddress'])
    postal_code = CGI.unescape(data[FORMAT_STRING % 'postalCode'])
    city = CGI.unescape(data[FORMAT_STRING % 'city'])
    country = CGI.unescape(data[FORMAT_STRING % 'country'])
    self.new(name, street_address, postal_code, city, country)
  end
end
end
