# frozen_string_literal: true

module PaysonAPI
  module V1
    module Errors
      class UnknownCurrencyError < StandardError
        def initialize(_msg, currency)
          super("Unknown currency: #{currency}")
        end
      end
    end
  end
end
