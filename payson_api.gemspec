# frozen_string_literal: true

require_relative 'lib/payson_api/version'

Gem::Specification.new do |s|
  s.name = 'payson_api'
  s.version = PaysonAPI::VERSION
  s.author = 'Christopher Svensson'
  s.email = 'stoffus@stoffus.com'
  s.homepage = 'https://github.com/stoffus/payson_api'
  s.summary = 'Client for Payson API'
  s.description = 'Client that enables access to the Payson payment gateway API.'
  s.license = 'MIT'

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_development_dependency 'rake', '~> 13'

  s.required_ruby_version = '>= 2.6.0'
end
