# frozen_string_literal: true

module PaysonAPI
  module V2
    module Requests
      class Merchant
        attr_accessor :checkout_uri, :notification_uri, :terms_uri, :confirmation_uri,
                      :partner_id, :validation_uri, :integration_info, :reference

        def to_hash
          {}.tap do |hash|
            hash['checkoutUri'] = @checkout_uri
            hash['notificationUri'] = @notification_uri
            hash['termsUri'] = @terms_uri
            hash['confirmationUri'] = @confirmation_uri
            hash['partnerId'] = @partner_id unless @partner_id.nil?
            hash['validationUri'] = @validation_uri unless @validation_uri.nil?
            hash['integrationInfo'] = @integration_info unless @integration_info.nil?
            hash['reference'] = @reference unless @reference.nil?
          end
        end
      end
    end
  end
end
