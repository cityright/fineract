# frozen_string_literal: true

module Fineract
  class Documents < Resource
    def list(entity_id, entity_type: "clients") = call(:retrieve_all_documents, path: entity_path(entity_type, entity_id))
    def create(entity_id, file:, entity_type: "clients", name: nil, description: nil, content_length: nil)
      validate_contract(Contracts::SpecialistResources::Document, { file: file })
      call(:create_document, path: entity_path(entity_type, entity_id), headers: { "Content-Length" => content_length }.compact, body: { "file" => file, "name" => name, "description" => description }.compact, request_type: "multipart/form-data", idempotent: false)
    rescue ValidationError => e
      Failure.new(e)
    end
    def retrieve(entity_id, document_id, entity_type: "clients") = call(:get_document, path: document_path(entity_type, entity_id, document_id))
    def update(entity_id, document_id, file:, entity_type: "clients", name: nil, description: nil, content_length: nil)
      validate_contract(Contracts::SpecialistResources::Document, { file: file })
      call(:update_document, path: document_path(entity_type, entity_id, document_id), headers: { "Content-Length" => content_length }.compact, body: { "file" => file, "name" => name, "description" => description }.compact, request_type: "multipart/form-data", idempotent: false)
    rescue ValidationError => e
      Failure.new(e)
    end
    def download(entity_id, document_id, entity_type: "clients") = call(:download_file, path: document_path(entity_type, entity_id, document_id), response_type: :binary)
    def delete(entity_id, document_id, entity_type: "clients") = call(:delete_document, path: document_path(entity_type, entity_id, document_id), idempotent: false)
    private
    def entity_path(entity_type, entity_id) = { entityType: entity_type.to_s, entityId: id!(entity_id, "entity_id") }
    def document_path(entity_type, entity_id, document_id) = entity_path(entity_type, entity_id).merge(documentId: id!(document_id, "document_id"))
  end
end
