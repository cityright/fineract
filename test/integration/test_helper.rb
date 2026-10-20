# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../support/integration_configuration"

unless IntegrationConfiguration.enabled?
  warn "Skipping integration tests; set FINERACT_INTEGRATION=1 to opt in"
  exit 0
end

INTEGRATION_CLIENT = Fineract.client(**IntegrationConfiguration.client_options)
