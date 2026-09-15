# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |task|
  task.libs << "test"
  task.pattern = "test/**/*_test.rb"
  task.warning = true
end

require "rubocop/rake_task"

RuboCop::RakeTask.new(:lint)

namespace :generated do
  desc "Fail when generated quality reports are stale"
  task :check do
    sh Gem.ruby, "bin/endpoint-coverage-catalog", "--check"
  end
end

namespace :endpoints do
  desc "Check that every endpoint declaration conforms to the endpoint inventory"
  task :conformance do
    ruby "-Itest", "test/endpoint_conformance_test.rb"
    sh Gem.ruby, "bin/endpoint-coverage-catalog", "--check"
  end

  desc "Regenerate the endpoint coverage report"
  task :report do
    sh Gem.ruby, "bin/endpoint-coverage-catalog"
  end
end

desc "Run all local quality gates"
task default: %i[test lint generated:check endpoints:conformance]
