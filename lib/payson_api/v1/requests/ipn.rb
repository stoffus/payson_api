# frozen_string_literal: true

module PaysonAPI
  module V1
    module Requests
      class IPN
        attr_accessor :data

        def initialize(data)
          @data = data
        end

        def to_s
          @data
        end
      end
    end
  end
end
