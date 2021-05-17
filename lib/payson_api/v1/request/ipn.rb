module PaysonAPI
  module V1
    module Request
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
