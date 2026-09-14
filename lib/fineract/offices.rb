# frozen_string_literal: true

module Fineract
  class Offices < Resource
    OFFICE_FIELDS = { name: "name", opening_date: "openingDate", parent_id: "parentId", external_id: "externalId", description: "description", hierarchy: "hierarchy" }.freeze
    def list(include_all_offices: nil, order_by: nil, sort_order: nil) = call(:retrieve_all_offices, query: { "includeAllOffices" => include_all_offices, "orderBy" => order_by, "sortOrder" => sort_order }.compact)
    def create(**attributes)
      validate_contract(Contracts::PhaseOne::OfficeCreate, attributes)
      call(:create_office, body: mapped_keys(attributes, OFFICE_FIELDS))
    rescue ValidationError => e
      Failure.new(e)
    end
    def retrieve(office_id) = safe_call { call(:retrieve_one_office, path: { officeId: id!(office_id, "office_id") }) }
    def update(office_id, **attributes) = safe_call { call(:update_office, path: { officeId: id!(office_id, "office_id") }, body: mapped_keys(attributes, OFFICE_FIELDS)) }
    private
    def validate_contract(contract, attributes)
      result = contract.new.call(attributes)
      raise ValidationError, result.errors.to_h.inspect unless result.success?
    end
  end
end
