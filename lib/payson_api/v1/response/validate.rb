module PaysonAPI
  module V1
    module Response
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
