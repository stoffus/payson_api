module PaysonAPI
  module V1
    module Request
      class PaymentUpdate
        attr_accessor :token, :action

        def initialize(token, action)
          @token = token
          if !PAYMENT_ACTIONS.include?(action)
            raise "Unknown payment update action: #{action}"
          end
          @action = action
        end

        def to_hash
          {}.tap do |hash|
            hash['token'] = @token
            hash['action'] = @action
          end
        end
      end
    end
  end
end
