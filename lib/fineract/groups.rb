# frozen_string_literal: true

module Fineract
  class Groups < Resource
    GROUP_FIELDS = { office_id: "officeId", activation_date: "activationDate", date_format: "dateFormat", locale: "locale", active: "active", name: "name", external_id: "externalId" }.freeze
    def list(**filters) = call(:retrieve_all_groups, query: mapped_keys(filters, office_id: "officeId", staff_id: "staffId", external_id: "externalId", under_hierarchy: "underHierarchy", paged: "paged", order_by: "orderBy", sort_order: "sortOrder", orphans_only: "orphansOnly"))
    def create(**attributes)
      validate_contract(Contracts::PhaseOne::GroupCreate, attributes)
      call(:create_group, body: mapped_keys(attributes, GROUP_FIELDS))
    rescue ValidationError => e
      Failure.new(e)
    end
    def retrieve(group_id, staff_in_selected_office_only: nil, role_id: nil) = safe_call { call(:retrieve_one_group, path: { groupId: id!(group_id, "group_id") }, query: { "staffInSelectedOfficeOnly" => staff_in_selected_office_only, "roleId" => role_id }.compact) }
    def update(group_id, **attributes) = safe_call { call(:update_group, path: { groupId: id!(group_id, "group_id") }, body: mapped_keys(attributes, GROUP_FIELDS)) }
    def delete(group_id) = safe_call { call(:delete_group, path: { groupId: id!(group_id, "group_id") }) }
    def template(**filters) = call(:retrieve_template_group, query: mapped_keys(filters, office_id: "officeId", center_id: "centerId", staff_in_selected_office_only: "staffInSelectedOfficeOnly"))
    private
    def validate_contract(contract, attributes)
      result = contract.new.call(attributes)
      raise ValidationError, result.errors.to_h.inspect unless result.success?
    end
  end
end
