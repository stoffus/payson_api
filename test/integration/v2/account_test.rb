# frozen_string_literal: true

require 'test/unit'
require_relative '../../helpers/v2/test_helper'
require_relative '../../../lib/payson_api'

class PaymentTest < Test::Unit::TestCase
  include TestHelper::V2

  def test_get_account
    account = PaysonAPI::V2::Client.get_account

    assert_equal 'Approved', account.status
  end

  def test_get_account_with_bad_credentials
    PaysonAPI::V2.config.api_user_id = 'invalid'

    assert_raise PaysonAPI::V2::Exceptions::UnauthorizedException do
      PaysonAPI::V2::Client.get_account
    end
  end
end
