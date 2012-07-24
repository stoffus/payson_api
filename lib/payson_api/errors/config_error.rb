module PaysonAPI
  module Errors
    class ConfigError < PaysonAPIError
      def initialize(msg)
        @msg = msg
      end

      def to_s
        @msg
      end
    end
  end
end
