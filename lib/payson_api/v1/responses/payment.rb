# frozen_string_literal: true

module PaysonAPI
  module V1
    module Responses
      class Payment
        attr_accessor :envelope, :token, :errors

        def initialize(data)
          @envelope = PaysonAPI::V1::Envelope.parse(data)
          @token = data['TOKEN']
          @errors = PaysonAPI::V1::RemoteError.parse(data)
        end

        def success?
          @envelope.ack == 'SUCCESS'
        end

        def forward_url
          PaysonAPI::V1.forward_url(@token)
        end
      end
    end
  end
end
