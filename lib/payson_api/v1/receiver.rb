# frozen_string_literal: true

require 'cgi'

module PaysonAPI
  module V1
    class Receiver
      FORMAT_STRING = "receiverList.receiver(%d).%s"
      attr_accessor :email, :amount, :first_name, :last_name, :primary

      def self.to_hash(receivers)
        {}.tap do |hash|
          receivers.each_with_index do |receiver, index|
            raise "Invalid receiver" unless receiver.instance_of?(self)
            hash.merge!({
              FORMAT_STRING % [index, 'email'] => receiver.email,
              FORMAT_STRING % [index, 'amount'] => receiver.amount,
              FORMAT_STRING % [index, 'firstName'] => receiver.first_name,
              FORMAT_STRING % [index, 'lastName'] => receiver.last_name,
              FORMAT_STRING % [index, 'primary'] => receiver.primary
            })
            if receiver.first_name
              hash[FORMAT_STRING % [index, 'firstName']] = receiver.first_name
            end
            if receiver.last_name
              hash[FORMAT_STRING % [index, 'lastName']] = receiver.last_name
            end
          end
        end
      end

      def self.parse(data)
        [].tap do |receivers|
          i = 0
          while data[FORMAT_STRING % [i, 'email']]
            receivers << self.new.tap do |r|
              r.email = CGI.unescape(data[FORMAT_STRING % [i, 'email']].to_s)
              r.amount = data[FORMAT_STRING % [i, 'amount']]
              r.first_name = CGI.unescape(data[FORMAT_STRING % [i, 'firstName']].to_s)
              r.last_name = CGI.unescape(data[FORMAT_STRING % [i, 'lastName']].to_s)
              r.primary = data[FORMAT_STRING % [i, 'primary']]
            end
            i += 1
          end
        end
      end
    end
  end
end
