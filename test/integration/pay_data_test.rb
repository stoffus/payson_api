# encoding: utf-8

require 'test/unit'
require 'test/integration_test_helper'
require 'payson_api'

class PayDataTest < Test::Unit::TestCase
  include IntegrationTestHelper

  def test_generated_hash_from_pay_data
    sender = PaysonAPI::Sender.new(
      CONFIG[:sender][:email],
      CONFIG[:sender][:first_name],
      CONFIG[:sender][:last_name]
    )

    receivers = []
    CONFIG[:receivers].each do |receiver|
      receivers << PaysonAPI::Receiver.new(
        receiver[:email],
        receiver[:amount]
      )
    end

    pay_data = PaysonAPI::PayData.new(
      CONFIG[:return_url],
      CONFIG[:cancel_url],
      CONFIG[:ipn_url],
      CONFIG[:memo],
      sender,
      receivers
    )

    order_items = []
    CONFIG[:order_items].each do |order_item|
      order_items << PaysonAPI::OrderItem.new(
        order_item[:description],
        order_item[:unit_price],
        order_item[:quantity],
        order_item[:tax],
        order_item[:sku]
      )
    end

    pay_data.order_items = order_items
    pay_data_hash = pay_data.to_hash

    assert_equal CONFIG[:return_url], pay_data_hash['returnUrl']
    assert_equal CONFIG[:cancel_url], pay_data_hash['cancelUrl']
    assert_equal CONFIG[:ipn_url], pay_data_hash['ipnNotificationUrl']
    assert_equal CONFIG[:memo], pay_data_hash['memo']

    # Ensure expected format of receiver list
    receiver_format = PaysonAPI::Receiver::FORMAT_STRING
    receivers.each_with_index do |receiver, index|
      email = pay_data_hash[receiver_format % [index, 'email']]
      amount = pay_data_hash[receiver_format % [index, 'amount']]

      assert_equal receiver.email, email
      assert_equal receiver.amount, amount
    end

    # Do same test for order items
    order_item_format = PaysonAPI::OrderItem::FORMAT_STRING
    order_items.each_with_index do |order_item, index|
      description = pay_data_hash[order_item_format % [index, 'description']]
      unit_price = pay_data_hash[order_item_format % [index, 'unitPrice']]
      quantity = pay_data_hash[order_item_format % [index, 'quantity']]
      tax = pay_data_hash[order_item_format % [index, 'taxPercentage']]
      sku = pay_data_hash[order_item_format % [index, 'sku']]

      assert_equal order_item.description, description
      assert_equal order_item.unit_price, unit_price
      assert_equal order_item.quantity, quantity
      assert_equal order_item.tax, tax
      assert_equal order_item.sku, sku
    end
  end
end
