require 'test/unit'
require_relative '../../helpers/v2/test_helper'
require_relative '../../../lib/payson_api'

class PaymentTest < Test::Unit::TestCase
  include TestHelper::V2

  def test_get_account
    account = PaysonAPI::V2::Client.get_account

    assert_equal 'Approved', account.status
  end

end
