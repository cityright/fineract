# frozen_string_literal: true

require_relative "lib/fineract/version"

Gem::Specification.new do |spec|
  spec.name = "fineract"
  spec.version = Fineract::VERSION
  spec.authors = ["kamalogudah"]
  spec.email = ["mcpaul2058@gmail.com"]

  spec.summary = "Fineract Ruby."
  spec.description = "Fineract Ruby."
  spec.homepage = "https://cityright.co.ke"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "activerecord", "~> 7.0", ">= 7.0.3.1"
  spec.add_dependency "activesupport", "~> 7.0", ">= 7.0.3.1"
  spec.add_dependency "attr_encrypted", "~> 3.1.0"
  spec.add_dependency "flexirest", ">=1.10.5"
  spec.add_dependency "request_store"
  spec.add_dependency "tty-logger"
  spec.add_dependency "typhoeus"
  spec.add_dependency "zeitwerk"

  spec.add_development_dependency "activerecord-nulldb-adapter"
  spec.add_development_dependency "climate_control"
  spec.add_development_dependency "dotenv", "2.7.6"
  spec.add_development_dependency "factory_bot"
  spec.add_development_dependency "faker"
  spec.add_development_dependency "faker-bot"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", "~> 3.11"
  spec.add_development_dependency "rubocop-rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "webmock", "~> 3.14"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
