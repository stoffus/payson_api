guard 'test' do
  watch(%r{^lib/(.+)\.rb$})      { "test" }
  watch(%r{^lib/payson_api/(.+)\.rb$})  { "test" }

  watch(%r{^test/unit/.+_test\.rb$}) { "test" }
  watch(%r{^test/fixtures/(.+)\.yml$}) { "test" }
  watch(%r{^test/integration/.+_test\.rb$}) { "test" }
  watch('test/.+\.rb')   { "test" }
end
