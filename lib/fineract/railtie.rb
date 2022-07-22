module Fineract
    class Railtie < Rails::Railtie
      initializer "fineract.configure_rails_initialization" do |app|
        require "fineract"
      end
    end
  end
  