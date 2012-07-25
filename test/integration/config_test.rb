# encoding: utf-8

require 'test/unit'
require 'test/integration_test_helper'
require 'payson_api'

class ConfigTest < Test::Unit::TestCase
  include IntegrationTestHelper

  def test_ensure_expected_config
    setup_config
    assert_equal PaysonAPI.config.api_user_id, CONFIG[:api_user_id]
    assert_equal PaysonAPI.config.api_password, CONFIG[:api_password]
  end
end
