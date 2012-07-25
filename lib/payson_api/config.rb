module PaysonAPI
  extend self

  PAYSON_WWW_HOST = "https://www.payson.se"
  PAYSON_WWW_PAY_FORWARD_URL = "/paysecure/?token=%s"

  PAYSON_API_ENDPOINT = "https://api.payson.se"
  PAYSON_API_VERSION = "1.0"
  PAYSON_API_PAY_ACTION = "Pay"
  PAYSON_API_PAYMENT_DETAILS_ACTION = "PaymentDetails"
  PAYSON_API_PAYMENT_UPDATE_ACTION = "PaymentUpdate"
  PAYSON_API_PAYMENT_VALIDATE_ACTION = "Validate"

  LOCALES = %w[SV FI EN]
  CURRENCIES = %w[SEK EUR]

  # Configures global settings for Payson
  # PaysonAPI.configure do |config|
  #   config.api_user = 12345
  # end
  def configure(&block)
    yield @config ||= Configuration.new
  end

  def config
    @config
  end

  class Configuration
    attr_accessor :api_user_id, :api_password
  end

  configure do |config|
    config.api_user_id = 'XXXX'
    config.api_password = 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX'
  end

end
