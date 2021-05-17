# frozen_string_literal: true

module PaysonAPI
  module V2
    module Exceptions
      class ValidationException < StandardError
        attr_reader :errors

        def initialize(msg = "Validation failed", errors)
          @errors = errors
          super(msg)
        end
      end
    end
  end
end
