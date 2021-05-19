# frozen_string_literal: true

require 'bundler/gem_tasks'

task default: ['test']

task :test do
  Rake::Task['test:v1:integration'].execute
  Rake::Task['test:v2:integration'].execute
end

namespace :test do
  namespace :v1 do
    desc 'Run integration tests'
    task :integration do
      Dir['test/integration/v1/*_test.rb'].each do |path|
        system "ruby -Ilib -Itest #{path}"
      end
    end
  end

  namespace :v2 do
    desc 'Run integration tests'
    task :integration do
      Dir['test/integration/v2/*_test.rb'].each do |path|
        system "ruby -Ilib -Itest #{path}"
      end
    end
  end
end
