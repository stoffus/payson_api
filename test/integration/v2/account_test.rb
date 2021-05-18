# frozen_string_literal: true

require 'test/unit'
require_relative '../../helpers/v2/test_helper'
require_relative '../../../lib/payson_api'

class PaymentTest < Test::Unit::TestCase
  include TestHelper::V2

  def test_get_account_info
    account = PaysonAPI::V2::Client.get_account_info

    assert_equal 'Approved', account.status
  end

  def test_get_account_info_with_bad_credentials
    PaysonAPI::V2.config.api_user_id = 'invalid'

    assert_raise PaysonAPI::V2::Errors::UnauthorizedError do
      PaysonAPI::V2::Client.get_account_info
    end
  end
end
