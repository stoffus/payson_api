guard 'test' do
  watch(%r{^lib/(.+)\.rb$}) { "test" }
  watch(%r{^lib/payson_api/v\d/(.+)\.rb$}) { "test" }

  watch(%r{^test/unit/.+_test\.rb$}) { "test" }
  watch(%r{^test/fixtures/(.+)\.yml$}) { "test" }
  watch(%r{^test/integration/.+_test\.rb$}) { "test" }
  watch(%r{^test/.+_helper\.rb$}) { "test" }
end
