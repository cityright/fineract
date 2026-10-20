# frozen_string_literal: true

require_relative "test_helper"

class LoanProductsIntegrationTest < Minitest::Test
  def test_loan_products_and_application_template_are_readable
    assert INTEGRATION_CLIENT.loan_products.list.success?
    assert INTEGRATION_CLIENT.loans.template.success?
  end
end
