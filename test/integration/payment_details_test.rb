# encoding: utf-8

require 'test/unit'
require 'test_helper'
require 'payson_api'

class PaymentDetailsTest < Test::Unit::TestCase
  include TestHelper

  def test_payment_details_request
    token = initiate_payment.token

    payment_details = PaysonAPI::Request::PaymentDetails.new(token)
    response = PaysonAPI::Client.get_payment_details(payment_details)

    assert response.success?
    assert_equal token, response.token
    assert_equal PAYMENT_DATA[:sender][:email], URI.unescape(response.sender_email)
    assert_equal PAYMENT_DATA[:currency], response.currency
  end
end
