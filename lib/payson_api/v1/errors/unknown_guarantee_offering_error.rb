# frozen_string_literal: true

module PaysonAPI
  module V1
    module Errors
      class UnknownGuaranteeOfferingError < StandardError
        def initialize(_msg, guarantee_offering)
          super("Unknown guarantee offering: #{guarantee_offering}")
        end
      end
    end
  end
end
