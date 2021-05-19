# frozen_string_literal: true

module PaysonAPI
  module V1
    module Errors
      class UnknownFundingConstraintError < StandardError
        def initialize(_msg, funding_constraint)
          super("Unknown funding constraint: #{funding_constraint}")
        end
      end
    end
  end
end
