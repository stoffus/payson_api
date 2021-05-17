# frozen_string_literal: true

module PaysonAPI
  module V2
    module Models
      class Merchant
        attr_accessor :checkout_uri, :confirmation_uri, :partner_id, :notification_uri,
          :validation_uri, :terms_uri, :integration_info, :reference    

        def self.from_json(json)
          self.new.tap do |merchant|
            merchant.checkout_uri = json['checkoutUri']
            merchant.confirmation_uri = json['confirmationUri']
            merchant.validation_uri = json['validationUri']
            merchant.terms_uri = json['termsUri']
            merchant.partner_id = json['partnerId']
            merchant.integration_info = json['integrationInfo']
            merchant.reference = json['reference']
          end
        end
      end
    end
  end
end
