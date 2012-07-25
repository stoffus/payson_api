# encoding: utf-8

require 'test/unit'
require 'test_helper'
require 'payson_api'

class PayDataTest < Test::Unit::TestCase
  include TestHelper
  ORDER = YAML.load_file('test/fixtures/order.yml')

  def test_request_and_fail_gracefully
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

    response = PaysonAPI::Client.pay(pay_data)

    # This should fail due to bad credentials
    assert_equal 'FAILURE', response.envelope['ack']
  end
end
