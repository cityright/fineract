# frozen_string_literal: true

module Fineract
  class Search < Resource
    ADVANCED_FIELDS = { date_format: "dateFormat", include_outstanding_amount: "includeOutstandingAmount",
                        include_outstanding_amount_percentage: "includeOutStandingAmountPercentage", loan_date_option: "loanDateOption", loan_from_date: "loanFromDate", loan_to_date: "loanToDate", locale: "locale", max_outstanding_amount: "maxOutstandingAmount", min_outstanding_amount: "minOutstandingAmount", outstanding_amount_percentage: "outStandingAmountPercentage", outstanding_amount_percentage_condition: "outStandingAmountPercentageCondition", outstanding_amount_condition: "outstandingAmountCondition" }.freeze
    def query(query:, resource: nil, exact_match: false)
      call(:search_data, query: { "query" => query, "resource" => resource, "exactMatch" => exact_match }.compact)
    end

    def advanced(**attributes)
      validate_contract(Contracts::PhaseOne::AdvancedSearch, attributes)
      call(:advanced_search, body: mapped_keys(attributes, ADVANCED_FIELDS))
    rescue ValidationError => e then Failure.new(e)
    end

    def template = call(:retrieve_ad_hoc_search_query_template)
  end
end
