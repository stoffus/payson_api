# frozen_string_literal: true

require 'test/unit'
require_relative '../../helpers/v1/test_helper'
require_relative '../../../lib/payson_api'

class PaymentDetailsTest < Test::Unit::TestCase
  include TestHelper::V1

  def test_payment_details_request
    token = initiate_payment.token

    payment_details = PaysonAPI::V1::Requests::PaymentDetails.new(token)
    response = PaysonAPI::V1::Client.get_payment_details(payment_details)

    assert response.success?
    assert_equal token, response.token
    assert_equal PAYMENT_DATA[:sender][:email], URI.decode_www_form_component(response.sender_email)
    assert_equal PAYMENT_DATA[:currency], response.currency
  end
end
