module PaysonAPI
  module V1
    module Errors
      class UnknownFundingConstraintError < StandardError
        def initialize(msg, funding_constraint)
          super("Unknown funding constraint: #{funding_constraint}")
        end
      end
    end
  end
end
