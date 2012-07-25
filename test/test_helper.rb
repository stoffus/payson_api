require 'yaml'

module TestHelper
  CONFIG = YAML.load_file('test/fixtures/config.yml')

  def setup
    PaysonAPI.configure do |config|
      config.api_user_id = CONFIG[:api_user_id]
      config.api_password = CONFIG[:api_password]
    end
  end

  def teardown
  end
end
