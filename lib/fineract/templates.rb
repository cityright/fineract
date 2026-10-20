# frozen_string_literal: true

module Fineract
  class Templates < Resource
    def list(type_id: nil, entity_id: nil)
      call(:retrieve_all_templates, query: { "typeId" => type_id, "entityId" => entity_id }.compact)
    end

    def create(**attributes)
      call(:create_template, body: mapped_keys(attributes), idempotent: false)
    end

    def details = call(:retrieve_template_details)

    def retrieve(template_id)
      safe_call { call(:retrieve_one_template, path: { templateId: id!(template_id, "template_id") }) }
    end

    def render(template_id)
      safe_call { call(:retrieve_template_by_id, path: { templateId: id!(template_id, "template_id") }) }
    end

    def update(template_id, **attributes)
      safe_call do
        call(:save_template, path: { templateId: id!(template_id, "template_id") }, body: mapped_keys(attributes),
                             idempotent: false)
      end
    end
    alias save update
    def merge(template_id, **attributes)
      safe_call do
        call(:merge_template, path: { templateId: id!(template_id, "template_id") }, body: mapped_keys(attributes),
                              response_type: :text, idempotent: false)
      end
    end

    def delete(template_id)
      safe_call { call(:delete_template, path: { templateId: id!(template_id, "template_id") }, idempotent: false) }
    end
  end
end
