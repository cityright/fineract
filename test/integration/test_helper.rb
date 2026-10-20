# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../support/integration_configuration"

INTEGRATION_CLIENT = Fineract.client(**IntegrationConfiguration.client_options) if IntegrationConfiguration.enabled?

# Base class for opt-in integration tests. Skips each test instead of exiting the
# process, so loading these files never cuts the rest of the suite short.
class IntegrationTest < Minitest::Test
  def setup
    super
    skip "set FINERACT_INTEGRATION=1 to opt in to integration tests" unless IntegrationConfiguration.enabled?
  end
end
