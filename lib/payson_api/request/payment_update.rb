module PaysonAPI
module Request
class PaymentUpdate
  attr_accessor :token, :action

  def initialize(token, action)
    @token = token
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
