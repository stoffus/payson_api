module PaysonAPI
  module V1
    module Errors
      class UnknownCurrencyError < StandardError
        def initialize(msg, currency)
          super("Unknown currency: #{currency}")
        end
      end
    end
  end
end
