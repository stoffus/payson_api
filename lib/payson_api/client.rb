require 'net/https'

module PaysonAPI
  class Client
    def self.pay(pay_data)
      action = '/%s/%s/' % [PAYSON_API_VERSION, PAYSON_API_PAY_ACTION]
      response = post(PAYSON_API_ENDPOINT + action, pay_data.to_hash)
      Response.new(response.body)
    end

  private

    def self.post(url, data)
      headers = {
        'PAYSON-SECURITY-USERID' => PaysonAPI.config.api_user_id,
        'PAYSON-SECURITY-PASSWORD' => PaysonAPI.config.api_password,
        'Content-Type' => 'application/x-www-form-urlencoded'
      }
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
  end
end
