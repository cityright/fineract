# frozen_string_literal: true

module Fineract
  class Groups < Resource
    GROUP_FIELDS = { office_id: "officeId", activation_date: "activationDate", date_format: "dateFormat",
                     locale: "locale", active: "active", name: "name", external_id: "externalId" }.freeze
    def list(**filters)
      call(:retrieve_all_groups,
           query: mapped_keys(filters, office_id: "officeId", staff_id: "staffId", external_id: "externalId", name: "name",
                                       under_hierarchy: "underHierarchy", paged: "paged", offset: "offset", limit: "limit", order_by: "orderBy", sort_order: "sortOrder", orphans_only: "orphansOnly"))
    end

    def create(**attributes)
      validate_contract(Contracts::PhaseOne::GroupCreate, attributes)
      call(:create_group, body: mapped_keys(attributes, GROUP_FIELDS))
    rescue ValidationError => e then Failure.new(e)
    end

    def retrieve(id, staff_in_selected_office_only: nil, role_id: nil)
      safe_call do
        call(:retrieve_one_group, path: { groupId: id!(id, "group_id") },
                                  query: { "staffInSelectedOfficeOnly" => staff_in_selected_office_only, "roleId" => role_id }.compact)
      end
    end

    def update(id, **a)
      safe_call do
        call(:update_group, path: { groupId: id!(id, "group_id") }, body: mapped_keys(a, GROUP_FIELDS),
                            idempotent: false)
      end
    end

    def delete(id) = safe_call { call(:delete_group, path: { groupId: id!(id, "group_id") }, idempotent: false) }
    def download_template(**q) = call(:get_bulk_template_group, query: mapped_keys(q), response_type: :binary)

    def upload_template(uploaded_input_stream:, locale: nil, date_format: nil)
      call(:post_bulk_template_group,
           body: { "uploadedInputStream" => uploaded_input_stream, "locale" => locale, "dateFormat" => date_format }.compact, request_type: "multipart/form-data", idempotent: false)
    end

    def template(**q) = call(:retrieve_template_group, query: mapped_keys(q))
    def accounts(id) = safe_call { call(:retrieve_accounts_group, path: { groupId: id!(id, "group_id") }) }
    alias account_overview accounts
    def command(id, command:, **a)
      safe_call do
        call(:handle_commands_group, path: { groupId: id!(id, "group_id") }, query: { "command" => command },
                                     body: mapped_keys(a), idempotent: false)
      end
    end

    def activate(id, activation_date:, **a) = command(id, command: "activate", activation_date: activation_date, **a)

    def close(id, closure_date:, closure_reason_id:, **a)
      command(id, command: "close", closure_date: closure_date, closure_reason_id: closure_reason_id, **a)
    end

    def assign_staff(id, staff_id:, **a) = command(id, command: "assignStaff", staff_id: staff_id, **a)

    def unassign_staff(id, staff_id:)
      safe_call do
        call(:unassign_loan_officer_group, path: { groupId: id!(id, "group_id") },
                                           body: { "staffId" => id!(staff_id, "staff_id") }, idempotent: false)
      end
    end

    def associate_clients(id, clients:)
      safe_call { command(id, command: "associateClients", clients: members(clients)) }
    end

    def disassociate_clients(id, clients:)
      safe_call { command(id, command: "disassociateClients", clients: members(clients)) }
    end

    def transfer_clients(id, destination_group_id:, clients:, **a)
      safe_call do
        command(id, command: "transferClients", destination_group_id: id!(destination_group_id, "destination_group_id"),
                    clients: members(clients), **a)
      end
    end

    def assign_role(id, client_id:, role:)
      command(id, command: "assignRole", client_id: id!(client_id, "client_id"), role: role)
    end

    def unassign_role(id, client_id:, role_id:)
      command(id, command: "unassignRole", client_id: id!(client_id, "client_id"), role_id: id!(role_id, "role_id"))
    end

    def update_role(id, client_id:, role:)
      command(id, command: "updateRole", client_id: id!(client_id, "client_id"), role: role)
    end

    def collection_sheet(id, **a) = command(id, command: "generateCollectionSheet", **a)

    private

    def members(values)
      raise ValidationError, "clients must be a non-empty Array" unless values.is_a?(Array) && !values.empty?

      values.map { |v| v.is_a?(Hash) ? v : { "id" => id!(v, "client_id") } }
    end
  end
end
