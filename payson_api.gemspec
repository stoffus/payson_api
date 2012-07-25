# encoding: utf-8

$:.push File.expand_path("../lib", __FILE__)
require "payson_api/version"

Gem::Specification.new do |s|
  s.name        = "payson_api"
  s.version     = PaysonAPI::VERSION
  s.authors     = ["Christopher Svensson"]
  s.email       = ["stoffus@stoffus.com"]
  s.homepage    = "https://github.com/stoffus/payson_api"
  s.summary     = %q{Client for Payson API}
  s.description = %q{Client that enables access to the Payson payment gateway API.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'httpclient'
end
