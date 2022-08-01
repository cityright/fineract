# frozen_string_literal: true

# rubocop:disable Style/Documentation
module Fineract
  class Railtie < Rails::Railtie
    initializer "fineract.configure_rails_initialization" do |_app|
      require "fineract"
    end
  end
end
# rubocop:enable Style/Documentation
