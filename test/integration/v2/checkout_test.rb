# frozen_string_literal: true

require 'test/unit'
require_relative '../../helpers/v2/test_helper'
require_relative '../../../lib/payson_api'

class PaymentTest < Test::Unit::TestCase
  include TestHelper::V2

  def test_get_checkouts
    page_size = 13
    page = 1
    request = PaysonAPI::V2::Requests::ListCheckouts.new(page_size, page)

    checkouts = PaysonAPI::V2::Client.list_checkouts(request)

    assert_equal page_size, checkouts.count

    checkout = PaysonAPI::V2::Client.get_checkout(checkouts[0].id)

    assert_equal checkouts[0].id, checkout.id
  end

  def test_create_checkout
    create_request = prepare_create_checkout_request
    created_checkout = PaysonAPI::V2::Client.create_checkout(create_request)

    assert_equal 'created', created_checkout.status
    assert_equal create_request.order.items.count, created_checkout.order.items.count
    assert_equal create_request.order.currency, created_checkout.order.currency
    assert_equal create_request.description, created_checkout.description
  end

  def test_update_checkout
    update_request = prepare_update_checkout_request(
      PaysonAPI::V2::Client.create_checkout(prepare_create_checkout_request)
    )

    updated_checkout = PaysonAPI::V2::Client.update_checkout(update_request)

    assert_equal update_request.order.items.count, updated_checkout.order.items.count
    assert_equal update_request.order.currency, updated_checkout.order.currency
    assert_equal update_request.description, updated_checkout.description
  end

  def test_create_checkout_with_invalid_currency
    create_request = prepare_create_checkout_request
    create_request.order.currency = 'invalid'

    exception = assert_raise PaysonAPI::V2::Errors::ValidationError do
      PaysonAPI::V2::Client.create_checkout(create_request)
    end

    assert_includes exception.errors.map { |e| e['property'] }, 'Order.Currency'
  end
end
