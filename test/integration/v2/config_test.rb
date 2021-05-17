# frozen_string_literal: true

require 'test/unit'
require_relative '../../helpers/v2/test_helper'
require_relative '../../../lib/payson_api'

class ConfigTest < Test::Unit::TestCase
  include TestHelper::V2

  def test_ensure_expected_config
    assert_equal CONFIG[:api_user_id], PaysonAPI::V2.config.api_user_id
    assert_equal CONFIG[:api_password], PaysonAPI::V2.config.api_password
  end

  def test_setting_test_mode
    PaysonAPI::V2.config.test_mode = true
    assert PaysonAPI::V2.test?
  end
end
