module PaysonAPI
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      desc <<DESC
Description:
Copies Payson configuration file to your application's initializer directory.
DESC

      def copy_config_file
        template 'payson_config.rb', 'config/initializers/payson_config.rb'
      end
    end
  end
end
