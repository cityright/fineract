# frozen_string_literal: true

module Fineract
  class Surveys < Resource
    class Legacy < Resource
      def list = call(:retrieve_all_surveys)
      def retrieve(name) = call(:retrieve_one_survey, path: { surveyName: survey_name(name) })

      def register(name, application_table, **attributes)
        call(:register, path: { surveyName: survey_name(name), apptable: application_table.to_s },
                        body: mapped_keys(attributes), idempotent: false)
      end

      def create_entry(name, application_table_id, **attributes)
        call(:create_survey_entry,
             path: { surveyName: survey_name(name), apptableId: id!(application_table_id, "application_table_id") }, body: mapped_keys(attributes), idempotent: false)
      end

      def client_overview(name, client_id)
        call(:get_client_survey_overview,
             path: { surveyName: survey_name(name), clientId: id!(client_id, "client_id") })
      end

      def entry(name, client_id, entry_id)
        call(:get_survey_entry,
             path: { surveyName: survey_name(name), clientId: id!(client_id, "client_id"),
                     entryId: id!(entry_id, "entry_id") })
      end

      def delete_entry(name, client_id, fulfilled_id)
        call(:delete_datatable_entries_1,
             path: { surveyName: survey_name(name), clientId: id!(client_id, "client_id"), fulfilledId: id!(fulfilled_id, "fulfilled_id") }, idempotent: false)
      end

      private

      def survey_name(value)
        value.to_s.tap { |name| raise ValidationError, "survey_name must not be empty" if name.empty? }
      end
    end

    class Scorecards < Resource
      def list_by_client(client_id) = call(:find_by_client, path: { clientId: id!(client_id, "client_id") })
      def list(survey_id) = call(:find_by_survey, path: { surveyId: id!(survey_id, "survey_id") })

      def list_for_client(survey_id, client_id)
        call(:find_by_survey_and_client,
             path: { surveyId: id!(survey_id, "survey_id"), clientId: id!(client_id, "client_id") })
      end

      def create(survey_id, **attributes)
        call(:create_scorecard, path: { surveyId: id!(survey_id, "survey_id") }, body: mapped_keys(attributes),
                                idempotent: false)
      end
    end

    class LookupTables < Resource
      def list(survey_id) = call(:fetch_lookup_tables, path: { surveyId: id!(survey_id, "survey_id") })

      def create(survey_id, **attributes)
        call(:create_lookup_table, path: { surveyId: id!(survey_id, "survey_id") }, body: mapped_keys(attributes),
                                   idempotent: false)
      end

      def retrieve(survey_id, key)
        call(:find_lookup_table, path: { surveyId: id!(survey_id, "survey_id"), key: key.to_s })
      end
    end

    attr_reader :legacy, :scorecards, :lookup_tables

    def list(is_active: nil) = call(:fetch_all_surveys, query: { "isActive" => is_active }.compact)
    def create(**attributes) = call(:create_survey, body: mapped_keys(attributes), idempotent: false)
    def retrieve(survey_id) = call(:find_survey, path: { id: id!(survey_id, "survey_id") })

    def update(survey_id, **attributes)
      call(:edit_survey, path: { id: id!(survey_id, "survey_id") }, body: mapped_keys(attributes), idempotent: false)
    end

    def activate(survey_id, command:)
      call(:activate_or_deactivate_survey, path: { id: id!(survey_id, "survey_id") }, query: { "command" => command },
                                           idempotent: false)
    end

    def initialize(client)
      super
      @legacy = Legacy.new(client)
      @scorecards = Scorecards.new(client)
      @lookup_tables = LookupTables.new(client)
    end
  end
end
