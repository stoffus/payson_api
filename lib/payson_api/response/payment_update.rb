module PaysonAPI
module Response
class PaymentUpdate
  attr_accessor :envelope, :errors

  def initialize(data)
    @envelope = Envelope.parse(data)
    @errors = RemoteError.parse(data)
  end

  def success?
    @envelope.ack == 'SUCCESS'
  end
end
end
end
