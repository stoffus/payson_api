require 'httpclient'

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
      HTTPClient.post(url, :body => data, :header => headers)
    end
  end
end
