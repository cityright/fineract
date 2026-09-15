# frozen_string_literal: true

module Fineract
  class Centers < Resource
    FIELDS = { office_id: "officeId", active: "active", name: "name" }.freeze
    def list(**q) = call(:retrieve_all_centers, query: mapped_keys(q))

    def create(**a)
      %i[name office_id active].each { |k| raise ValidationError, "#{k} is required" unless a.key?(k) }
      call(:create_center, body: mapped_keys(a, FIELDS), idempotent: false)
    rescue ValidationError => e then Failure.new(e)
    end

    def retrieve(id, staff_in_selected_office_only: nil)
      safe_call do
        call(:retrieve_one_center, path: { centerId: id!(id, "center_id") },
                                   query: { "staffInSelectedOfficeOnly" => staff_in_selected_office_only }.compact)
      end
    end

    def update(id, **a)
      safe_call do
        call(:update_center, path: { centerId: id!(id, "center_id") }, body: mapped_keys(a), idempotent: false)
      end
    end

    def delete(id) = safe_call { call(:delete_center, path: { centerId: id!(id, "center_id") }, idempotent: false) }
    def download_template(**q) = call(:get_bulk_template_center, query: mapped_keys(q), response_type: :binary)

    def upload_template(uploaded_input_stream:, locale: nil, date_format: nil)
      call(:post_bulk_template_center,
           body: { "uploadedInputStream" => uploaded_input_stream, "locale" => locale, "dateFormat" => date_format }.compact, request_type: "multipart/form-data", idempotent: false)
    end

    def template(**q) = call(:retrieve_template_center, query: mapped_keys(q))
    def accounts(id) = safe_call { call(:retrieve_group_accounts_center, path: { centerId: id!(id, "center_id") }) }
    alias account_overview accounts
    def command(id, command:, **a)
      safe_call do
        call(:handle_commands_center, path: { centerId: id!(id, "center_id") }, query: { "command" => command },
                                      body: mapped_keys(a), idempotent: false)
      end
    end

    def activate(id, **a) = command(id, command: "activate", **a)
    def close(id, **a) = command(id, command: "close", **a)
    def associate_groups(id, groups:) = command(id, command: "associateGroups", groups: groups)
    def disassociate_groups(id, groups:) = command(id, command: "disassociateGroups", groups: groups)
    def collection_sheet(id, **a) = command(id, command: "generateCollectionSheet", **a)
  end
end
