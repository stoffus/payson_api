module PaysonAPI
  module V1
    module Errors
      class UnknownPaymentActionError < StandardError
        def initialize(msg, locale)
          super("Unknown payment action: #{locale}")
        end
      end
    end
  end
end
