require 'cgi'

module PaysonAPI
  module V1
    class Sender
      FORMAT_STRING = "sender%s"
      attr_accessor :email, :first_name, :last_name

      def initialize(email, first_name, last_name)
        @email = email
        @first_name = first_name
        @last_name = last_name
      end

      def to_hash
        {}.tap do |hash|
          hash[FORMAT_STRING % 'Email'] = @email
          hash[FORMAT_STRING % 'FirstName'] = @first_name
          hash[FORMAT_STRING % 'LastName'] = @last_name
        end
      end

      def self.parse(data)
        email = data[FORMAT_STRING % 'email']
        first_name = CGI.unescape(data[FORMAT_STRING % 'FirstName'].to_s)
        last_name = CGI.unescape(data[FORMAT_STRING % 'LastName'].to_s)
        self.new(email, first_name, last_name)
      end
    end
  end
end
