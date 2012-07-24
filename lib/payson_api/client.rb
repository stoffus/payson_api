require 'rest_client'

module PaysonAPI
  class Client
    def self.pay(pay_data)
      action = '/%s/%s/' % [PAYSON_API_VERSION, PAYSON_API_PAY_ACTION]
      headers = {
        "PAYSON-SECURITY-USERID" => PaysonAPI.config.api_user,
        "PAYSON-SECURITY-PASSWORD" => PaysonAPI.config.api_key
      }
      response = RestClient.post(PAYSON_API_ENDPOINT + action,
        pay_data.to_hash,
        headers
      )
      Response.new(response)
    end
  end
end
