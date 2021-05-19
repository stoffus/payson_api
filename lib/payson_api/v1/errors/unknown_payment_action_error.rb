# frozen_string_literal: true

module PaysonAPI
  module V1
    module Errors
      class UnknownPaymentActionError < StandardError
        def initialize(_msg, locale)
          super("Unknown payment action: #{locale}")
        end
      end
    end
  end
end
