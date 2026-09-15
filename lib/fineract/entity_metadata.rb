# frozen_string_literal: true

module Fineract
  class EntityDatatableChecks < Resource
    def list(status: nil, entity: nil, product_id: nil, offset: nil, limit: nil)
      call(:retrieve_all_entity_datatable_checks,
           query: mapped_keys({ status: status, entity: entity, product_id: product_id, offset: offset, limit: limit }.compact))
    end

    def create(entity:, status:, datatable_name:, product_id: nil)
      attributes = { entity: entity, status: status, datatable_name: datatable_name, product_id: product_id }.compact
      validate_contract(Contracts::EntityMetadata::EntityDatatableCheckCreate, attributes)
      call(:create_entity_datatable_check, body: mapped_keys(attributes), idempotent: false)
    rescue ValidationError => e
      Failure.new(e)
    end

    def template = call(:retrieve_template_entity_datatable_checks)

    def delete(id) = safe_call { call(:delete_entity_datatable_check, path: { entityDatatableCheckId: id!(id, "entity_datatable_check_id") }, idempotent: false) }
  end

  class EntityFieldConfiguration < Resource
    def retrieve(entity) = safe_call { call(:get_addresses, path: { entity: entity.to_s }) }

    alias find retrieve
  end
end
