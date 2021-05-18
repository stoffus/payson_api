# frozen_string_literal: true

module PaysonAPI
  module V2
    module Models
      class Merchant
        attr_accessor :checkout_uri, :confirmation_uri, :partner_id, :notification_uri,
          :validation_uri, :terms_uri, :integration_info, :reference

        def self.from_hash(hash)
          self.new.tap do |merchant|
            merchant.checkout_uri = hash['checkoutUri']
            merchant.confirmation_uri = hash['confirmationUri']
            merchant.validation_uri = hash['validationUri']
            merchant.terms_uri = hash['termsUri']
            merchant.partner_id = hash['partnerId']
            merchant.integration_info = hash['integrationInfo']
            merchant.reference = hash['reference']
          end
        end
      end
    end
  end
end
