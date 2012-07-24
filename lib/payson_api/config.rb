require 'active_support/configurable'
require 'logger'

module PaysonAPI
  # Some hard constants
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
  def self.configure(&block)
    yield @config ||= PaysonAPI::Configuration.new
  end

  def self.config
    @config
  end

  class Configuration
    include ActiveSupport::Configurable
    config_accessor :api_user
    config_accessor :api_key
    config_accessor :logger
  end

  configure do |config|
    config.api_user = 'XXXX'
    config.api_key = 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX'
    config.logger = Logger.new(STDOUT)
  end

end
