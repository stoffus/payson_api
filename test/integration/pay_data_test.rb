# encoding: utf-8

require 'test/unit'
require 'test_helper'
require 'payson_api'

class PayDataTest < Test::Unit::TestCase
  include TestHelper
  ORDER = YAML.load_file('test/fixtures/order.yml')

  def test_generated_hash_from_pay_data
    sender = PaysonAPI::Sender.new(
      ORDER[:sender][:email],
      ORDER[:sender][:first_name],
      ORDER[:sender][:last_name]
    )

    receivers = []
    ORDER[:receivers].each do |receiver|
      receivers << PaysonAPI::Receiver.new(
        receiver[:email],
        receiver[:amount]
      )
    end

    pay_data = PaysonAPI::PayData.new(
      ORDER[:return_url],
      ORDER[:cancel_url],
      ORDER[:ipn_url],
      ORDER[:memo],
      sender,
      receivers
    )

    order_items = []
    ORDER[:order_items].each do |order_item|
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

    assert_equal ORDER[:return_url], pay_data_hash['returnUrl']
    assert_equal ORDER[:cancel_url], pay_data_hash['cancelUrl']
    assert_equal ORDER[:ipn_url], pay_data_hash['ipnNotificationUrl']
    assert_equal ORDER[:memo], pay_data_hash['memo']

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
