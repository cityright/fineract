# frozen_string_literal: true

require_relative "lib/fineract/version"

Gem::Specification.new do |spec|
  spec.name = "fineract"
  spec.version = Fineract::VERSION
  spec.authors = ["kamalogudah"]
  spec.email = ["mcpaul2058@gmail.com"]

  spec.summary = "A framework-agnostic Ruby client for Apache Fineract"
  spec.description = "A typed, resource-oriented Ruby client for the Apache Fineract 1.15.0 API."
  spec.homepage = "https://github.com/cityright/fineract"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/cityright/fineract"
  spec.metadata["changelog_uri"] = "https://github.com/cityright/fineract/blob/main/CHANGELOG.md"
  spec.metadata["documentation_uri"] = "https://github.com/cityright/fineract#readme"
  spec.metadata["bug_tracker_uri"] = "https://github.com/cityright/fineract/issues"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["lib/**/*", "sig/**/*", "specifications/*.json", "CHANGELOG.md", "CODE_OF_CONDUCT.md",
        "LICENSE.txt", "README.md"].select { |path| File.file?(path) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "dry-configurable", "~> 1.0"
  spec.add_dependency "dry-container", "~> 0.11"
  spec.add_dependency "dry-monads", "~> 1.6"
  spec.add_dependency "dry-struct", "~> 1.6"
  spec.add_dependency "dry-types", "~> 1.7"
  spec.add_dependency "dry-validation", "~> 1.10"
  spec.add_dependency "faraday", "~> 2.0"
  spec.add_dependency "faraday-retry", "~> 2.0"

  spec.add_development_dependency "guard-minitest"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "simplecov"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
