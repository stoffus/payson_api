module PaysonAPI
module Response
class Payment
  attr_accessor :envelope, :token, :errors

  def initialize(data)
    @envelope = Envelope.parse(data)
    @token = data['TOKEN']
    @errors = RemoteError.parse(data)
  end

  def success?
    @envelope.ack == 'SUCCESS'
  end

  def forward_url
    PAYSON_WWW_HOST + PAYSON_WWW_PAY_FORWARD_URL % @token
  end
end
end
end
