# frozen_string_literal: true

# rubocop:disable all

module Fineract
  class PlatformAdministration < Resource
    class GlobalConfiguration < Resource
      def list(survey: nil) = call(:retrieve_configuration, query: { "survey" => survey }.compact)
      def retrieve(id) = safe_call { call(:retrieve_one_global_configuration, path: { configId: id!(id, "config_id") }) }
      def retrieve_by_name(name) = call(:retrieve_one_by_name, path: { name: name })
      def update(id, **attrs) = safe_call { call(:update_global_configuration, path: { configId: id!(id, "config_id") }, body: wire_keys(attrs)) }
      def update_by_name(name, **attrs) = call(:update_configuration_by_name, path: { configName: name }, body: wire_keys(attrs))
    end

    class ExternalServices < Resource
      def retrieve(name) = call(:retrieve_external_services_configuration, path: { servicename: name })
      def update(name, **attrs) = call(:update_external_services_configuration, path: { servicename: name }, body: wire_keys(attrs))
    end

    class Cache < Resource
      def list = call(:retrieve_all_2)
      def switch(cache_type:, **attrs) = call(:switch_cache, body: wire_keys(attrs.merge(cache_type: cache_type)))
    end

    class Hooks < Resource
      def list = call(:retrieve_all_hooks)
      def create(**attrs) = call(:create_hook, body: wire_keys(attrs))
      def template = call(:retrieve_template_hook)
      def retrieve(id, template: nil) = safe_call { call(:retrieve_one_hook, path: { hookId: id!(id, "hook_id") }, query: { "template" => template }.compact) }
      def update(id, **attrs) = safe_call { call(:update_hook, path: { hookId: id!(id, "hook_id") }, body: wire_keys(attrs)) }
      def delete(id) = safe_call { call(:delete_hook, path: { hookId: id!(id, "hook_id") }) }
    end

    class AccountNumberFormats < Resource
      def list = call(:retrieve_all_account_number_formats)
      def create(**attrs) = call(:create_account_number_format, body: wire_keys(attrs))
      def template = call(:retrieve_template_account_number_format)
      def retrieve(id) = safe_call { call(:retrieve_one_account_number_format, path: { accountNumberFormatId: id!(id, "format_id") }) }
      def update(id, **attrs) = safe_call { call(:update_account_number_format, path: { accountNumberFormatId: id!(id, "format_id") }, body: wire_keys(attrs)) }
      def delete(id) = safe_call { call(:delete_account_number_format, path: { accountNumberFormatId: id!(id, "format_id") }) }
    end

    class SchedulerJobs < Resource
      def list = call(:retrieve_all_scheduler_jobs)
      def retrieve(id) = safe_call { call(:retrieve_one_scheduler_job, path: { jobId: id!(id, "job_id") }) }
      def retrieve_by_short_name(name) = call(:retrieve_by_short_name, path: { shortName: name })
      def update(id, **attrs) = safe_call { call(:update_job_detail, path: { jobId: id!(id, "job_id") }, body: wire_keys(attrs)) }
      def update_by_short_name(name, **attrs) = call(:update_job_detail_by_short_name, path: { shortName: name }, body: wire_keys(attrs))
      def history(id, **query) = safe_call { call(:retrieve_history, path: { jobId: id!(id, "job_id") }, query: wire_keys(query)) }
      def history_by_short_name(name, **query) = call(:retrieve_history_by_short_name, path: { shortName: name }, query: wire_keys(query))
      def execute(id, command: nil, **attrs) = safe_call { call(:execute_job, path: { jobId: id!(id, "job_id") }, query: { "command" => command }.compact, body: attrs.empty? ? nil : wire_keys(attrs), idempotent: false) }
      def execute_by_short_name(name, command: nil, **attrs) = call(:execute_job_by_short_name, path: { shortName: name }, query: { "command" => command }.compact, body: attrs.empty? ? nil : wire_keys(attrs), idempotent: false)
    end

    class Audits < Resource
      def list(**query) = call(:retrieve_audit_entries, query: wire_keys(query))
      def search_template = call(:retrieve_audit_search_template)
      def retrieve(id) = safe_call { call(:retrieve_audit_entry, path: { auditId: id!(id, "audit_id") }) }
    end

    class MakerChecker < Resource
      def list(**query) = call(:retrieve_commands, query: wire_keys(query))
      def search_template = call(:retrieve_audit_search_template_1)
      def approve(id, command: nil) = safe_call { call(:approve_maker_checker_entry, path: { auditId: id!(id, "audit_id") }, query: { "command" => command }.compact, idempotent: false) }
      def delete(id) = safe_call { call(:delete_maker_checker_entry, path: { auditId: id!(id, "audit_id") }) }
    end

    class BatchRequests < Resource
      def submit(requests, enclosing_transaction: nil) = call(:handle_batch_requests, query: { "enclosingTransaction" => enclosing_transaction }.compact, body: requests, idempotent: false)
      alias create submit
    end

    class Notifications < Resource
      def list(**query) = call(:get_all_notifications, query: wire_keys(query))
      def mark_read = call(:update_notification_read_status, idempotent: false)
    end

    class Scheduler < Resource
      def status = call(:retrieve_scheduler_status)
      def command(command:) = call(:handle_commands_scheduler, query: { "command" => command }, idempotent: false)
    end

    attr_reader :global_configuration, :external_services, :cache, :hooks, :account_number_formats,
                :scheduler_jobs, :audits, :maker_checker, :batch_requests, :notifications, :scheduler

    def initialize(client)
      super
      @global_configuration = GlobalConfiguration.new(client)
      @external_services = ExternalServices.new(client)
      @cache = Cache.new(client)
      @hooks = Hooks.new(client)
      @account_number_formats = AccountNumberFormats.new(client)
      @scheduler_jobs = SchedulerJobs.new(client)
      @audits = Audits.new(client)
      @maker_checker = MakerChecker.new(client)
      @batch_requests = BatchRequests.new(client)
      @notifications = Notifications.new(client)
      @scheduler = Scheduler.new(client)
    end
  end

  Administration = PlatformAdministration
end

# rubocop:enable all
