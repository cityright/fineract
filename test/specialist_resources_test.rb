# frozen_string_literal: true

require "json"
require "stringio"
require "test_helper"

class SpecialistResourcesTest < Minitest::Test
  def client_with(stubs) = Fineract.client(adapter: [:test, stubs])

  def test_templates_map_filters_and_alternate_html_merge_response
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.get("/fineract-provider/api/v1/templates") do |env|
      assert_equal({ "typeId" => "2", "entityId" => "9" }, env.params)
      [200, { "Content-Type" => "application/json" }, "[]"]
    end
    stubs.post("/fineract-provider/api/v1/templates/4") do |env|
      assert_equal "application/json", env.request_headers["Content-Type"]
      [200, { "Content-Type" => "text/html" }, "<html>merged</html>"]
    end
    client = client_with(stubs)
    assert client.templates.list(type_id: 2, entity_id: 9).success?
    result = client.templates.merge(4, name: "statement")
    assert_equal "<html>merged</html>", result.value!.data
    stubs.verify_stubbed_calls
  end

  def test_documents_upload_update_and_download
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/clients/7/documents") do |env|
      assert_includes env.request_headers["Content-Type"], "multipart/form-data"
      assert_includes env.body, "filename=\"note.txt\""
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    stubs.put("/fineract-provider/api/v1/clients/7/documents/8") do |env|
      assert_equal 12, env.request_headers["Content-Length"]
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    stubs.get("/fineract-provider/api/v1/clients/7/documents/8/attachment") do
      [200, { "Content-Type" => "application/pdf" }, "%PDF"]
    end
    client = client_with(stubs)
    file = StringIO.new("hello")
    file.define_singleton_method(:original_filename) { "note.txt" }
    assert client.documents.create(7, file: file).success?
    assert client.documents.update(7, 8, file: StringIO.new("updated"), content_length: 12).success?
    assert_equal "%PDF", client.documents.download(7, 8).value!.data
    stubs.verify_stubbed_calls
  end

  def test_spm_surveys_and_self_service_are_exposed
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.get("/fineract-provider/api/v1/surveys/5/lookuptables") do
      [200, { "Content-Type" => "application/json" }, "[]"]
    end
    stubs.get("/fineract-provider/api/v1/notifications") do |env|
      assert_equal "true", env.params["isRead"]
      [200, { "Content-Type" => "application/json" }, "[]"]
    end
    client = client_with(stubs)
    assert client.surveys.lookup_tables.list(5).success?
    assert client.self_service.notifications(is_read: true).success?
    assert_instance_of Fineract::Surveys::Legacy, client.surveys.legacy
    stubs.verify_stubbed_calls
  end
end
