# frozen_string_literal: true

require 'yaml'

module TestHelper
  module V1
    CONFIG = YAML.load_file('test/fixtures/v1/config.yml')
    PAYMENT_DATA = YAML.load_file('test/fixtures/v1/payment_data.yml')

    def setup
      PaysonAPI::V1.configure do |config|
        config.api_user_id = CONFIG[:api_user_id]
        config.api_password = CONFIG[:api_password]
      end
    end

    def prepare_payment_request(include_order_items = false)
      sender = PaysonAPI::V1::Sender.new.tap do |s|
        s.email = PAYMENT_DATA[:sender][:email]
        s.first_name = PAYMENT_DATA[:sender][:first_name]
        s.last_name = PAYMENT_DATA[:sender][:last_name]
      end

      receivers = []
      PAYMENT_DATA[:receivers].each do |receiver|
        receivers << PaysonAPI::V1::Receiver.new.tap do |r|
          r.email = receiver[:email]
          r.amount = receiver[:amount]
          r.first_name = receiver[:first_name]
          r.last_name = receiver[:last_name]
          r.primary = receiver[:primary]
        end
      end

      request = PaysonAPI::V1::Requests::Payment.new
      request.return_url = PAYMENT_DATA[:return_url]
      request.cancel_url = PAYMENT_DATA[:cancel_url]
      request.ipn_url = PAYMENT_DATA[:ipn_url]
      request.memo = PAYMENT_DATA[:memo]
      request.sender = sender
      request.receivers = receivers

      if include_order_items
        request.order_items = []
        PAYMENT_DATA[:order_items].each do |order_item|
          request.order_items << PaysonAPI::V1::OrderItem.new.tap do |item|
            item.description = order_item[:description]
            item.unit_price = order_item[:unit_price]
            item.quantity = order_item[:quantity]
            item.tax = order_item[:tax]
            item.sku = order_item[:sku]
          end
        end
      end

      request.fundings = []
      PAYMENT_DATA[:fundings].each do |funding|
        request.fundings << PaysonAPI::V1::Funding.new.tap do |f|
          f.constraint = funding[:constraint]
        end
      end

      request.fees_payer = PAYMENT_DATA[:fees_payer]
      request.locale = PAYMENT_DATA[:locale]
      request.guarantee_offered = PAYMENT_DATA[:guarantee_offered]
      request.currency = PAYMENT_DATA[:currency]

      request
    end

    def initiate_payment
      PaysonAPI::V1::Client.initiate_payment(prepare_payment_request.to_hash)
    end

    def teardown
    end
  end
end
