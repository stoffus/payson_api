module PaysonAPI
  module V1
    module Errors
      class UnknownLocaleError < StandardError
        def initialize(msg, locale)
          super("Unknown locale: #{locale}")
        end
      end
    end
  end
end
