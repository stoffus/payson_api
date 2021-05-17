require 'test/unit'
require_relative '../../helpers/v1/test_helper'
require_relative '../../../lib/payson_api'

class ConfigTest < Test::Unit::TestCase
  include TestHelper::V1

  def test_ensure_expected_config
    assert_equal CONFIG[:api_user_id], PaysonAPI::V1.config.api_user_id
    assert_equal CONFIG[:api_password], PaysonAPI::V1.config.api_password
    assert PaysonAPI::V1.test?
  end

  def test_setting_test_mode
    PaysonAPI::V1.config.api_user_id = '123'
    assert !PaysonAPI::V1.test?
    PaysonAPI::V1.config.test_mode = true
    assert PaysonAPI::V1.test?
  end
end
