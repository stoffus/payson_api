# frozen_string_literal: true

module PaysonAPI
  module V2
    module_function

    PAYSON_API_ENDPOINT = 'https://%s.payson.se'
    PAYSON_API_VERSION = '2.0'
    PAYSON_API_RESOURCES = {
      checkouts: {
        create: 'Checkouts',
        update: 'Checkouts/%s',
        get: 'Checkouts/%s',
        list: 'Checkouts'
      },
      accounts: {
        get: 'Accounts'
      }
    }.freeze

    PAYSON_API_TEST_ENDPOINT = 'https://test-api.payson.se'

    LOCALES = %w[SV EN FI].freeze
    CURRENCIES = %w[sek eur].freeze

    def configure
      yield @config ||= Configuration.new # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def config
      @config
    end

    class Configuration
      attr_accessor :api_user_id, :api_password, :test_mode
    end

    configure do |config|
      config.api_user_id = 'XXXX'
      config.api_password = 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX'
    end

    def test?
      @config.test_mode || @config.api_user_id == '4'
    end

    def api_base_url
      test? ? PAYSON_API_TEST_ENDPOINT : PAYSON_API_ENDPOINT
    end
  end
end
