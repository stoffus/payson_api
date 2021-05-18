# frozen_string_literal: true

require 'test/unit'
require_relative '../../helpers/v1/test_helper'
require_relative '../../../lib/payson_api'

class PaymentTest < ::Test::Unit::TestCase
  include ::TestHelper::V1

  def test_payment_initiation
    response = initiate_payment

    assert(response.success?)
    assert(response.forward_url =~ /test-www/)
  end

  def test_payment_hash
    request = prepare_payment_request(include_order_items: true)
    request_hash = request.to_hash

    assert_equal(PAYMENT_DATA[:return_url], request.return_url)
    assert_equal(PAYMENT_DATA[:cancel_url], request.cancel_url)
    assert_equal(PAYMENT_DATA[:ipn_url], request.ipn_url)
    assert_equal(PAYMENT_DATA[:memo], request.memo)
    assert_equal(PAYMENT_DATA[:locale], request.locale)

    # Ensure expected format of receiver list
    receiver_format = ::PaysonAPI::V1::Receiver::FORMAT_STRING
    request.receivers.each_with_index do |receiver, index|
      email = request_hash[format(receiver_format, index, 'email')]
      amount = request_hash[format(receiver_format, index, 'amount')]
      first_name = request_hash[format(receiver_format, index, 'firstName')]
      last_name = request_hash[format(receiver_format, index, 'lastName')]
      primary = request_hash[format(receiver_format, index, 'primary')]

      assert_equal(receiver.email, email)
      assert_equal(receiver.amount, amount)
      assert_equal(receiver.first_name, first_name)
      assert_equal(receiver.last_name, last_name)
      assert_equal(receiver.primary, primary)
    end

    # Do same test for order items
    order_item_format = ::PaysonAPI::V1::OrderItem::FORMAT_STRING
    request.order_items.each_with_index do |order_item, index|
      description = request_hash[format(order_item_format, index, 'description')]
      unit_price = request_hash[format(order_item_format, index, 'unitPrice')]
      quantity = request_hash[format(order_item_format, index, 'quantity')]
      tax = request_hash[format(order_item_format, index, 'taxPercentage')]
      sku = request_hash[format(order_item_format, index, 'sku')]

      assert_equal(order_item.description, description)
      assert_equal(order_item.unit_price, unit_price)
      assert_equal(order_item.quantity, quantity)
      assert_equal(order_item.tax, tax)
      assert_equal(order_item.sku, sku)
    end

    # Ensure expected format of fundings list
    funding_format = ::PaysonAPI::V1::Funding::FORMAT_STRING
    request.fundings.each_with_index do |funding, index|
      constraint = request_hash[format(funding_format, index, 'constraint')]
      assert_equal(funding.constraint, constraint)
    end
  end
end
