# frozen_string_literal: true

module PaysonAPI
  module V1
    module Errors
      class UnknownFeesPayerError < StandardError
        def initialize(_msg, fees_payer)
          super("Unknown fees payer: #{fees_payer}")
        end
      end
    end
  end
end
