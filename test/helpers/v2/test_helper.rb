# frozen_string_literal: true

require 'yaml'

module TestHelper
  module V2
    CONFIG = ::YAML.load_file('test/fixtures/v2/config.yml')
    CREATE_CHECKOUT_DATA = ::YAML.load_file('test/fixtures/v2/create_checkout_data.yml')
    UPDATE_CHECKOUT_DATA = ::YAML.load_file('test/fixtures/v2/update_checkout_data.yml')

    def setup
      ::PaysonAPI::V2.configure do |config|
        config.api_user_id = CONFIG[:api_user_id]
        config.api_password = CONFIG[:api_password]
        config.test_mode = true
      end
    end

    def fetch_random_checkout
      ::PaysonAPI::V2::Client.list_checkouts(::PaysonAPI::V2::Requests::ListCheckouts.new(1, 1)).first
    end

    def prepare_create_checkout_request
      request = ::PaysonAPI::V2::Requests::CreateCheckout.new

      request.merchant.checkout_uri = CREATE_CHECKOUT_DATA[:merchant][:checkout_url]
      request.merchant.confirmation_uri = CREATE_CHECKOUT_DATA[:merchant][:confirmation_url]
      request.merchant.notification_uri = CREATE_CHECKOUT_DATA[:merchant][:notification_url]
      request.merchant.terms_uri = CREATE_CHECKOUT_DATA[:merchant][:terms_url]

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

    def prepare_update_checkout_request(checkout)
      request = PaysonAPI::V2::Requests::UpdateCheckout.new
      request.status = checkout.status
      request.id = checkout.id

      request.merchant.checkout_uri = UPDATE_CHECKOUT_DATA[:merchant][:checkout_url]
      request.merchant.confirmation_uri = UPDATE_CHECKOUT_DATA[:merchant][:confirmation_url]
      request.merchant.notification_uri = UPDATE_CHECKOUT_DATA[:merchant][:notification_url]
      request.merchant.terms_uri = UPDATE_CHECKOUT_DATA[:merchant][:terms_url]

      request.order.currency = UPDATE_CHECKOUT_DATA[:order][:currency]
      UPDATE_CHECKOUT_DATA[:order][:items].each do |item|
        request.order.items << PaysonAPI::V2::Requests::OrderItem.new.tap do |order_item|
          order_item.name = item[:name]
          order_item.unit_price = item[:unit_price]
          order_item.quantity = item[:quantity]
          order_item.reference = item[:reference]
        end
      end

      request
    end

    def teardown; end
  end
end
