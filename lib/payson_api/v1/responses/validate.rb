# frozen_string_literal: true

module PaysonAPI
  module V1
    module Responses
      class Validate
        attr_accessor :data

        def initialize(data)
          @data = data
        end

        def verified?
          @data == 'VERIFIED'
        end
      end
    end
  end
end
