# frozen_string_literal: true

FactoryBot.define do
  factory :login, class: Fineract::Api::Login do
    expires_in { "3599" }
    access_token { Faker::Internet.device_token }
  end

  factory :login_credentials, class: Hash do
    private_key { "SomePrivateKey" }
    public_key { "SomePublicKey" }

    initialize_with { attributes }
  end
end
