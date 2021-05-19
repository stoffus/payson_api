# frozen_string_literal: true

module PaysonAPI
  module V1
    module Requests
      class PaymentUpdate
        attr_accessor :token, :action

        def initialize(token, action)
          unless PaysonAPI::V1::PAYMENT_ACTIONS.include?(action)
            raise PaysonAPI::V1::Errors::UnknownPaymentActionError(action)
          end

          @token = token
          @action = action
        end

        def to_hash
          {}.tap do |hash|
            hash['token'] = @token
            hash['action'] = @action
          end
        end
      end
    end
  end
end
