# frozen_string_literal: true

require 'yaml'

module TestHelper
  module V2
    CONFIG = YAML.load_file('test/fixtures/v2/config.yml')
    CREATE_CHECKOUT_DATA = YAML.load_file('test/fixtures/v2/create_checkout_data.yml')
    UPDATE_CHECKOUT_DATA = YAML.load_file('test/fixtures/v2/update_checkout_data.yml')

    def setup
      PaysonAPI::V2.configure do |config|
        config.api_user_id = CONFIG[:api_user_id]
        config.api_password = CONFIG[:api_password]
        config.test_mode = true
      end
    end

    def fetch_random_checkout
      PaysonAPI::V2::Client.list_checkouts(PaysonAPI::V2::Requests::ListCheckouts.new(1, 1)).first
    end

    def prepare_create_checkout_request
      request = PaysonAPI::V2::Requests::CreateCheckout.new

      append_merchant(request, CREATE_CHECKOUT_DATA)

      request.order.currency = CREATE_CHECKOUT_DATA[:order][:currency]
      CREATE_CHECKOUT_DATA[:order][:items].each do |item|
        request.order.items << PaysonAPI::V2::Requests::OrderItem.new.tap do |order_item|
          order_item.name = item[:name]
          order_item.unit_price = item[:unit_price]
          order_item.quantity = item[:quantity]
          order_item.reference = item[:reference]
        end
      end

      request
    end

    def append_merchant(request, data)
      request.merchant.checkout_uri = data[:merchant][:checkout_url]
      request.merchant.confirmation_uri = data[:merchant][:confirmation_url]
      request.merchant.notification_uri = data[:merchant][:notification_url]
      request.merchant.terms_uri = data[:merchant][:terms_url]
    end

    def append_order_items(request)
      UPDATE_CHECKOUT_DATA[:order][:items].each do |item|
        request.order.items << PaysonAPI::V2::Requests::OrderItem.new.tap do |order_item|
          order_item.name = item[:name]
          order_item.unit_price = item[:unit_price]
          order_item.quantity = item[:quantity]
          order_item.reference = item[:reference]
        end
      end
    end

    def prepare_update_checkout_request(checkout)
      request = PaysonAPI::V2::Requests::UpdateCheckout.new
      request.status = checkout.status
      request.id = checkout.id
      request.order.currency = UPDATE_CHECKOUT_DATA[:order][:currency]

      append_merchant(request, UPDATE_CHECKOUT_DATA)
      append_order_items(request)

      request
    end

    def teardown; end
  end
end
