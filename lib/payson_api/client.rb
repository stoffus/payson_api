require 'net/https'

module PaysonAPI
  class Client
    def self.initiate_payment(payment_data)
      response_hash = payson_request(
        PAYSON_API_PAY_ACTION,
        payment_data
      )
      PaysonAPI::Response::Payment.new(response_hash)
    end

    def self.get_payment_details(payment_details_data)
      response_hash = payson_request(
        PAYSON_API_PAYMENT_DETAILS_ACTION,
        payment_details_data
      )
      PaysonAPI::Response::PaymentDetails.new(response_hash)
    end

    def self.update_payment(payment_update_data)
      response_hash = payson_request(
        PAYSON_API_PAYMENT_DETAILS_ACTION,
        payment_update_data
      )
      PaysonAPI::Response::PaymentUpdate.new(response_hash)
    end

  private

    def self.payson_request(action, data)
      action = '/%s/%s/' % [PAYSON_API_VERSION, action]
      url = PAYSON_API_ENDPOINT + action
      headers = {
        'PAYSON-SECURITY-USERID' => PaysonAPI.config.api_user_id,
        'PAYSON-SECURITY-PASSWORD' => PaysonAPI.config.api_password,
        'Content-Type' => 'application/x-www-form-urlencoded'
      }
      response = post(url, data.to_hash, headers)
      response_hash = params_to_hash(response.body)
      response_hash
    end

    def self.post(url, data, headers)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.use_ssl = uri.scheme == 'https'
      req = Net::HTTP::Post.new(uri.path)
      req.body = hash_to_params(data)
      headers.each do |name, value|
        req[name] = value
      end
      http.request(req)
    end

    def self.hash_to_params(hash)
      out = ""
      hash.each { |k, v| out << "#{k}=#{v}&" }
      out.chop
    end

    def self.params_to_hash(params)
      {}.tap do |hash|
        parts = params.split(/&/)
        parts.each do |part|
          key, val = part.split(/=/)
          hash[key] = val
        end
      end
    end
  end
end
