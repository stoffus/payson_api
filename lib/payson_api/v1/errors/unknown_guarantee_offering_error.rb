module PaysonAPI
  module V1
    module Errors
      class UnknownGuaranteeOfferingError < StandardError
        def initialize(msg, guarantee_offering)
          super("Unknown guarantee offering: #{guarantee_offering}")
        end
      end
    end
  end
end
