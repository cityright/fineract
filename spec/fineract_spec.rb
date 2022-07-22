# frozen_string_literal: true

RSpec.describe FineractRuby do
  it "has a version number" do
    expect(FineractRuby::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end

  it 'queries FactoryBot contributors on GitHub' do
    uri = URI('https://api.github.com/repos/thoughtbot/factory_bot/contributors')

    response = Net::HTTP.get(uri)

    expect(response).to be_an_instance_of(String)
  end
end
