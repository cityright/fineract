# # frozen_string_literal: true

# require_relative "fineract/version"
# require 'dotenv/load'

# module Fineract
#   autoload :Auth, "fineract/api/auth/basic"
#   autoload :Error, "fineract/api/error"
  
#   # Your code goes here...
# end


# frozen_string_literal: true

begin
  require 'dotenv/load' # eager load env
rescue LoadError => _e
  nil
end

require 'active_record'
require 'attr_encrypted'
require 'flexirest'
require 'fineract/railtie' if defined?(Rails)
require 'request_store'
require 'tty-logger'
require 'zeitwerk'

Flexirest::Base.faraday_config do |faraday|
  faraday.adapter(:net_http)
  faraday.options.timeout       = 10
  faraday.ssl.verify            = false
end
loader = Zeitwerk::Loader.for_gem
railtie = "#{__dir__}/fineract/railtie.rb"
loader.do_not_eager_load(railtie)

loader.setup

module Fineract
  APP_ROOT = __dir__
end

loader.eager_load
