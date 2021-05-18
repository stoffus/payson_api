# frozen_string_literal: true

require 'cgi'

module PaysonAPI
  module V1
    class Sender
      FORMAT_STRING = "sender%s"
      attr_accessor :email, :first_name, :last_name

      def to_hash
        {}.tap do |hash|
          hash[FORMAT_STRING % 'Email'] = @email
          hash[FORMAT_STRING % 'FirstName'] = @first_name
          hash[FORMAT_STRING % 'LastName'] = @last_name
        end
      end

      def self.parse(data)
        self.new.tap do |s|
          s.email = data[FORMAT_STRING % 'email']
          s.first_name = CGI.unescape(data[FORMAT_STRING % 'FirstName'].to_s)
          s.last_name = CGI.unescape(data[FORMAT_STRING % 'LastName'].to_s)
        end
      end
    end
  end
end
