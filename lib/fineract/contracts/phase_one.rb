# frozen_string_literal: true

require "dry/validation"

module Fineract
  module Contracts
    module PhaseOne
      class ClientCreate < Dry::Validation::Contract
        params do
          required(:firstname).filled(:string)
          required(:lastname).filled(:string)
          required(:office_id).filled(:integer)
        end
        rule(:office_id) { key.failure("must be a positive integer") unless value.positive? }
      end
      class GroupCreate < Dry::Validation::Contract
        params do
          required(:name).filled(:string)
          required(:office_id).filled(:integer)
          required(:active).filled(:bool)
        end
        rule(:office_id) { key.failure("must be a positive integer") unless value.positive? }
      end
      class OfficeCreate < Dry::Validation::Contract
        params do
          required(:name).filled(:string)
          required(:opening_date).filled(:string)
          required(:parent_id).filled(:integer)
        end
        rule(:parent_id) { key.failure("must be a positive integer") unless value.positive? }
      end

      class GLAccountCreate < Dry::Validation::Contract
        params do
          required(:name).filled(:string)
          required(:gl_code).filled(:string)
          required(:type).filled(:integer)
          required(:usage).filled(:integer)
        end
      end

      class AccountingRuleCreate < Dry::Validation::Contract
        params do
          required(:name).filled(:string)
          required(:account_to_debit).filled(:integer)
          required(:account_to_credit).filled(:integer)
        end
      end

      class GLClosureCreate < Dry::Validation::Contract
        params do
          required(:office_id).filled(:integer)
          required(:closing_date).filled(:string)
        end
      end

      class FinancialActivityMappingCreate < Dry::Validation::Contract
        params do
          required(:financial_activity_id).filled(:integer)
          required(:gl_account_id).filled(:integer)
        end
      end

      class LoanProductCreate < Dry::Validation::Contract
        params do
          required(:name).filled(:string)
          required(:short_name).filled(:string)
          required(:currency_code).filled(:string)
        end
      end

      class LoanApplicationCreate < Dry::Validation::Contract
        params do
          required(:client_id).filled(:integer)
          required(:product_id).filled(:integer)
          required(:principal).filled
          required(:submitted_on_date).filled(:string)
        end
        rule(:client_id) { key.failure("must be a positive integer") unless value.positive? }
        rule(:product_id) { key.failure("must be a positive integer") unless value.positive? }
        rule(:principal) { key.failure("must be a positive number") unless value.is_a?(Numeric) && value.positive? }
      end

      class ProductMix < Dry::Validation::Contract
        params do
          required(:restricted_products).array(:integer, min_size?: 1)
        end
        rule(:restricted_products) { key.failure("must contain only positive integers") unless value.all?(&:positive?) }
      end

      class ShareProductCreate < Dry::Validation::Contract
        params do
          required(:name).filled(:string)
          required(:short_name).filled(:string)
          required(:currency_code).filled(:string)
          required(:unit_price).filled
        end
        rule(:unit_price) { key.failure("must be a positive amount") unless value.is_a?(Numeric) && value.positive? }
      end

      class ShareAccountCreate < Dry::Validation::Contract
        params do
          required(:client_id).filled(:integer)
          required(:product_id).filled(:integer)
          required(:application_date).filled(:string)
          required(:requested_shares).filled(:integer)
        end
        rule(:client_id) { key.failure("must be a positive integer") unless value.positive? }
        rule(:product_id) { key.failure("must be a positive integer") unless value.positive? }
        rule(:requested_shares) { key.failure("must be positive") unless value.positive? }
      end

      class AccountTransferCreate < Dry::Validation::Contract
        params do
          required(:from_account_id).filled
          required(:to_account_id).filled
          required(:transfer_amount).filled
          required(:transfer_date).filled(:string)
        end
        rule(:transfer_amount) { key.failure("must be a positive amount") unless value.is_a?(Numeric) && value.positive? }
      end

      class ReportCreate < Dry::Validation::Contract
        params do
          required(:report_name).filled(:string)
          required(:report_sql).filled(:string)
          required(:report_type).filled(:string)
        end
      end

      class ReportMailingJobCreate < Dry::Validation::Contract
        params do
          required(:name).filled(:string)
          required(:recurrence).filled(:string)
          required(:email_recipients).filled(:string)
          required(:start_date_time).filled(:string)
        end
      end

      class AdvancedSearch < Dry::Validation::Contract
        params do
          optional(:loan_from_date).maybe(:string)
          optional(:loan_to_date).maybe(:string)
          optional(:loan_date_option).maybe(:string)
          optional(:min_outstanding_amount).maybe(:integer)
          optional(:max_outstanding_amount).maybe(:integer)
        end
      end
    end
  end
end
