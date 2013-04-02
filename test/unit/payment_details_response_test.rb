#encoding: utf-8
require 'test/unit'
require 'payson_api'

class PaymentDetailsResponseTest < Test::Unit::TestCase

  def test_guarantee_timestamp
    data = {'responseEnvelope.%s' % 'ack' => "SUCCESS",
            'responseEnvelope.%s' % 'timestamp' => Time.new,
            'responseEnvelope.%s' % 'correlationId' => 1}

    data['type'] = 'GUARANTEE'
    data['guaranteeStatus'] = 'WAITINGFORSEND'
    data['guaranteeDeadlineTimestamp'] = '2013-04-05T20%3a26%3a29'
    guarantee_response = PaysonAPI::Response::PaymentDetails.new(data)
    assert_equal DateTime.parse('2013-04-05T20:26:29'), guarantee_response.guarantee_deadline_at, "guaranteeDeadlineTimestamp should handle to be created from html-encoded string"
  end

end