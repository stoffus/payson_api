# frozen_string_literal: true

module PaysonAPI
  module V1
    module Responses
      class PaymentUpdate
        attr_accessor :envelope, :errors

        def initialize(data)
          @envelope = PaysonAPI::V1::Envelope.parse(data)
          @errors = PaysonAPI::V1::RemoteError.parse(data)
        end

        def success?
          @envelope.ack == 'SUCCESS'
        end
      end
    end
  end
end
