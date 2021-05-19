# frozen_string_literal: true

require 'test/unit'
require_relative '../../helpers/v1/test_helper'
require_relative '../../../lib/payson_api'

class PaymentTest < Test::Unit::TestCase
  include TestHelper::V1

  def test_payment_initiation
    response = initiate_payment

    assert response.success?
    assert response.forward_url =~ /test-www/
  end

  def test_payment_receivers
    request = prepare_payment_request(include_order_items: false)
    hash = request.to_hash

    request.receivers.each_with_index do |receiver, index|
      assert_equal receiver.email, hash[format(PaysonAPI::V1::Receiver::FORMAT_STRING, index, 'email')]
      assert_equal receiver.amount, hash[format(PaysonAPI::V1::Receiver::FORMAT_STRING, index, 'amount')]
      assert_equal receiver.first_name, hash[format(PaysonAPI::V1::Receiver::FORMAT_STRING, index, 'firstName')]
      assert_equal receiver.last_name, hash[format(PaysonAPI::V1::Receiver::FORMAT_STRING, index, 'lastName')]
      assert_equal receiver.primary, hash[format(PaysonAPI::V1::Receiver::FORMAT_STRING, index, 'primary')]
    end
  end

  def test_payment_order_items
    request = prepare_payment_request(include_order_items: true)
    hash = request.to_hash

    request.order_items.each_with_index do |order_item, index|
      assert_equal order_item.description, hash[format(PaysonAPI::V1::OrderItem::FORMAT_STRING, index, 'description')]
      assert_equal order_item.unit_price, hash[format(PaysonAPI::V1::OrderItem::FORMAT_STRING, index, 'unitPrice')]
      assert_equal order_item.quantity, hash[format(PaysonAPI::V1::OrderItem::FORMAT_STRING, index, 'quantity')]
      assert_equal order_item.tax, hash[format(PaysonAPI::V1::OrderItem::FORMAT_STRING, index, 'taxPercentage')]
      assert_equal order_item.sku, hash[format(PaysonAPI::V1::OrderItem::FORMAT_STRING, index, 'sku')]
    end
  end

  def test_payment_fundings
    request = prepare_payment_request(include_order_items: true)
    hash = request.to_hash

    request.fundings.each_with_index do |funding, index|
      assert_equal funding.constraint, hash[format(PaysonAPI::V1::Funding::FORMAT_STRING, index, 'constraint')]
    end
  end

  def test_payment_data
    request = prepare_payment_request(include_order_items: false)

    assert_equal PAYMENT_DATA[:return_url], request.return_url
    assert_equal PAYMENT_DATA[:cancel_url], request.cancel_url
    assert_equal PAYMENT_DATA[:ipn_url], request.ipn_url
    assert_equal PAYMENT_DATA[:memo], request.memo
    assert_equal PAYMENT_DATA[:locale], request.locale
  end
end
