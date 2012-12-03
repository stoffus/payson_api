# encoding: utf-8

require 'test/unit'
require 'test_helper'
require 'payson_api'

class PaymentTest < Test::Unit::TestCase
  include TestHelper

  def test_payment_initiation
    response = initiate_payment

    assert response.success?
    assert response.forward_url =~ /test-www/
  end

  def test_generated_hash_from_payment_data
    setup_payment_hash(include_order_items = true)

    assert_equal PAYMENT_DATA[:return_url], @payment_hash['returnUrl']
    assert_equal PAYMENT_DATA[:cancel_url], @payment_hash['cancelUrl']
    assert_equal PAYMENT_DATA[:ipn_url], @payment_hash['ipnNotificationUrl']
    assert_equal PAYMENT_DATA[:memo], @payment_hash['memo']
    assert_equal PAYMENT_DATA[:locale], @payment_hash['localeCode']

    # Ensure expected format of receiver list
    receiver_format = PaysonAPI::Receiver::FORMAT_STRING
    @receivers.each_with_index do |receiver, index|
      email = @payment_hash[receiver_format % [index, 'email']]
      amount = @payment_hash[receiver_format % [index, 'amount']]
      first_name = @payment_hash[receiver_format % [index, 'firstName']]
      last_name = @payment_hash[receiver_format % [index, 'lastName']]
      primary = @payment_hash[receiver_format % [index, 'primary']]

      assert_equal receiver.email, email
      assert_equal receiver.amount, amount
      assert_equal receiver.first_name, first_name
      assert_equal receiver.last_name, last_name
      assert_equal receiver.primary, primary
    end

    # Do same test for order items
    order_item_format = PaysonAPI::OrderItem::FORMAT_STRING
    @order_items.each_with_index do |order_item, index|
      description = @payment_hash[order_item_format % [index, 'description']]
      unit_price = @payment_hash[order_item_format % [index, 'unitPrice']]
      quantity = @payment_hash[order_item_format % [index, 'quantity']]
      tax = @payment_hash[order_item_format % [index, 'taxPercentage']]
      sku = @payment_hash[order_item_format % [index, 'sku']]

      assert_equal order_item.description, description
      assert_equal order_item.unit_price, unit_price
      assert_equal order_item.quantity, quantity
      assert_equal order_item.tax, tax
      assert_equal order_item.sku, sku
    end

    # Ensure expected format of fundings list
    funding_format = PaysonAPI::Funding::FORMAT_STRING
    @fundings.each_with_index do |funding, index|
      constraint = @payment_hash[funding_format % [index, 'constraint']]
      assert_equal funding.constraint, constraint
    end
  end
end
