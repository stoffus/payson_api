require 'yaml'

module IntegrationTestHelper
  CONFIG = YAML.load_file('test/config.yml')

  def setup_config
    PaysonAPI.configure do |config|
      config.api_user_id = CONFIG[:api_user_id]
      config.api_password = CONFIG[:api_password]
    end
  end
end
