# frozen_string_literal: true

module PaysonAPI
  module V1
    module Errors
      class UnknownLocaleError < StandardError
        def initialize(_msg, locale)
          super("Unknown locale: #{locale}")
        end
      end
    end
  end
end
