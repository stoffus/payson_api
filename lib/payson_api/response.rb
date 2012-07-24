module PaysonAPI
class Response
  attr_accessor :envelope, :token, :errors

  def initialize(response)
    @errors = {}
    @envelope = {}
    @token = nil
    parse_response(response)
  end

  def parse_response(response)
    response.split(/&/).each do |item|
      if item =~ /TOKEN/
        @token = item.split(/=/)[1]
      elsif item =~ /errorId/
        code = item.split(/=/)[1]
        @errors[code] = Errors::RemoteError::ERROR_CODES[code]
      elsif item =~ /responseEnvelope/
        name, value = item.split(/=/)
        name = name.split(/\./)[1]
        @envelope[name] = value
      end
    end
  end

  def success?
    @envelope['ack'] == 'SUCCESS'
  end

  def forward_url
    url = PAYSON_WWW_HOST + PAYSON_WWW_PAY_FORWARD_URL % @token
  end
end
end
