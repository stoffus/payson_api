# encoding: utf-8

require 'test/unit'
require 'test_helper'
require 'payson_api'

class PaymentDetailsTest < Test::Unit::TestCase
  include TestHelper

  def test_generated_hash_from_payment_details
    token = acquire_token

    if !token
      puts "Token was not received, please look into your test config"
      return
    end

    payment_details = PaysonAPI::Request::PaymentDetails.new(token)
    response = PaysonAPI::Client.get_payment_details(payment_details)
  end
end
