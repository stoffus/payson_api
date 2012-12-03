require 'net/https'

module PaysonAPI
class Client
  def self.initiate_payment(payment_data)
    response = payson_request(
      PAYSON_API_PAY_ACTION,
      payment_data.to_hash
    )
    response_hash = params_to_hash(response.body)
    PaysonAPI::Response::Payment.new(response_hash)
  end

  def self.get_payment_details(payment_details_data)
    response = payson_request(
      PAYSON_API_PAYMENT_DETAILS_ACTION,
      payment_details_data.to_hash
    )
    response_hash = params_to_hash(response.body)
    PaysonAPI::Response::PaymentDetails.new(response_hash)
  end

  def self.update_payment(payment_update_data)
    response = payson_request(
      PAYSON_API_PAYMENT_DETAILS_ACTION,
      payment_update_data.to_hash
    )
    response_hash = params_to_hash(response.body)
    PaysonAPI::Response::PaymentUpdate.new(response_hash)
  end

  def self.validate_ipn(ipn_data)
    response = payson_request(
      PAYSON_API_PAYMENT_VALIDATE_ACTION,
      ipn_data.to_s
    )
    PaysonAPI::Response::Validate.new(response.body)
  end

  def self.hash_to_params(hash)
    hash.map { |k, v| "#{k}=#{v}" }.join('&')
  end

  def self.params_to_hash(params)
    {}.tap do |hash|
      params.split('&').each do |param|
        key, val = param.split('=')
        hash[key] = val
      end
    end
  end

private

  def self.payson_request(action, data)
    action = '/%s/%s/' % [PAYSON_API_VERSION, action]
    url = PAYSON_API_ENDPOINT % (PaysonAPI.test? ? 'test-api' : 'api') + action
    headers = {
      'PAYSON-SECURITY-USERID' => PaysonAPI.config.api_user_id,
      'PAYSON-SECURITY-PASSWORD' => PaysonAPI.config.api_password,
      'Content-Type' => 'application/x-www-form-urlencoded'
    }
    post(url, data, headers)
  end

  def self.post(url, data, headers)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = uri.scheme == 'https'
    req = Net::HTTP::Post.new(uri.path)
    req.body = data.is_a?(Hash) ? hash_to_params(data) : data
    headers.each do |name, value|
      req[name] = value
    end
    http.request(req)
  end
end
end
