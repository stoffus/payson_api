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

    def prepare_sender(sender)
      PaysonAPI::V1::Sender.new.tap do |s|
        s.email = sender[:email]
        s.first_name = sender[:first_name]
        s.last_name = sender[:last_name]
      end
    end

    def prepare_order_item(order_item)
      PaysonAPI::V1::OrderItem.new.tap do |item|
        item.description = order_item[:description]
        item.unit_price = order_item[:unit_price]
        item.quantity = order_item[:quantity]
        item.tax = order_item[:tax]
        item.sku = order_item[:sku]
      end
    end

    def prepare_receiver(receiver)
      PaysonAPI::V1::Receiver.new.tap do |r|
        r.email = receiver[:email]
        r.amount = receiver[:amount]
        r.first_name = receiver[:first_name]
        r.last_name = receiver[:last_name]
        r.primary = receiver[:primary]
      end
    end

    def prepare_receivers(receivers)
      [].tap do |r|
        receivers.each do |receiver|
          r << prepare_receiver(receiver)
        end
      end
    end

    def append_order_items(request)
      request.order_items = []
      PAYMENT_DATA[:order_items].each do |order_item|
        request.order_items << prepare_order_item(order_item)
      end
    end

    def append_fundings(request)
      request.fundings = []
      PAYMENT_DATA[:fundings].each do |funding|
        request.fundings << PaysonAPI::V1::Funding.new.tap do |f|
          f.constraint = funding[:constraint]
        end
      end
    end

    def prepare_payment_request(include_order_items: false)
      request = PaysonAPI::V1::Requests::Payment.new
      request.return_url = PAYMENT_DATA[:return_url]
      request.cancel_url = PAYMENT_DATA[:cancel_url]
      request.ipn_url = PAYMENT_DATA[:ipn_url]
      request.memo = PAYMENT_DATA[:memo]
      request.sender = prepare_sender(PAYMENT_DATA[:sender])
      request.receivers = prepare_receivers(PAYMENT_DATA[:receivers])
      request.fees_payer = PAYMENT_DATA[:fees_payer]
      request.locale = PAYMENT_DATA[:locale]
      request.guarantee_offered = PAYMENT_DATA[:guarantee_offered]
      request.currency = PAYMENT_DATA[:currency]

      append_order_items(request) if include_order_items
      append_fundings(request)

      request
    end

    def initiate_payment
      PaysonAPI::V1::Client.initiate_payment(prepare_payment_request(include_order_items: false).to_hash)
    end

    def teardown; end
  end
end
