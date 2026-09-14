# frozen_string_literal: true

module Fineract
  class Reporting < Resource
    REPORT_FIELDS = { description: "description", report_category: "reportCategory", report_name: "reportName", report_parameters: "reportParameters", report_sql: "reportSql", report_sub_type: "reportSubType", report_type: "reportType" }.freeze
    MAILING_FIELDS = { date_format: "dateFormat", description: "description", email_message: "emailMessage", email_recipients: "emailRecipients", email_subject: "emailSubject", is_active: "isActive", locale: "locale", name: "name", recurrence: "recurrence", start_date_time: "startDateTime", stretchy_report_id: "stretchyReportId", stretchy_report_param_map: "stretchyReportParamMap" }.freeze
    REPORT_QUERY = { offset: "offset", limit: "limit", order_by: "orderBy", sort_order: "sortOrder" }.freeze
    RUN_QUERY = { export_csv: "exportCSV", parameter_type: "parameterType", output_type: "output-type", office_id: "R_officeId", loan_officer_id: "R_loanOfficerId", from_date: "R_fromDate", to_date: "R_toDate", currency_id: "R_currencyId", account_no: "R_accountNo" }.freeze

    class Reports < Resource
      def list = call(:retrieve_all_reports)
      def create(**attributes)
        validate_contract(Contracts::PhaseOne::ReportCreate, attributes)
        call(:create_report, body: mapped_keys(attributes, Reporting::REPORT_FIELDS), idempotent: false)
      rescue ValidationError => e then Failure.new(e)
      end
      def template = call(:retrieve_template_report)
      def retrieve(report_id) = safe_call { call(:retrieve_one_report, path: { id: id!(report_id, "report_id") }) }
      def update(report_id, **attributes) = safe_call { call(:update_report, path: { id: id!(report_id, "report_id") }, body: mapped_keys(attributes, Reporting::REPORT_FIELDS), idempotent: false) }
      def delete(report_id) = safe_call { call(:delete_report, path: { id: id!(report_id, "report_id") }, idempotent: false) }
    end

    class Runner < Resource
      RESPONSE_TYPES = { json: "application/json", csv: "text/csv", pdf: "application/pdf", xls: "application/vnd.ms-excel", html: "text/html", text: "text/plain", binary: "application/octet-stream" }.freeze
      def run(report_name, format: :json, **query)
        response_type = RESPONSE_TYPES.fetch(format.to_sym) { raise ValidationError, "unsupported report format: #{format}" }
        query = { output_type: format.to_s.upcase, **query } unless query.key?(:output_type)
        call(:run_report, path: { reportName: report_name.to_s }, query: report_query(query), response_type: response_type)
      rescue ValidationError => e
        Failure.new(e)
      end
      def available_exports(report_name) = safe_call { call(:retrieve_all_available_exports, path: { reportName: report_name.to_s }) }

      private
      def report_query(query)
        mapped_keys(query, Reporting::RUN_QUERY).transform_values { |value| value.is_a?(Numeric) ? value.to_s : value }
      end
    end

    class MailingJobs < Resource
      def list(**query) = call(:retrieve_all_report_mailing_jobs, query: mapped_keys(query, Reporting::REPORT_QUERY))
      def create(**attributes)
        validate_contract(Contracts::PhaseOne::ReportMailingJobCreate, attributes)
        call(:create_report_mailing_job, body: mapped_keys(attributes, Reporting::MAILING_FIELDS), idempotent: false)
      rescue ValidationError => e then Failure.new(e)
      end
      def template = call(:retrieve_template_report_mailing_job)
      def run_history(**query) = call(:retrieve_all_report_mailing_job_run_history, query: mapped_keys(query, report_mailing_job_id: "reportMailingJobId", **Reporting::REPORT_QUERY))
      def retrieve(job_id) = safe_call { call(:retrieve_one_report_mailing_job, path: { entityId: id!(job_id, "job_id") }) }
      def update(job_id, **attributes) = safe_call { call(:update_report_mailing_job, path: { entityId: id!(job_id, "job_id") }, body: mapped_keys(attributes, Reporting::MAILING_FIELDS), idempotent: false) }
      def delete(job_id) = safe_call { call(:delete_report_mailing_job, path: { entityId: id!(job_id, "job_id") }, idempotent: false) }
    end

    attr_reader :reports, :runner, :mailing_jobs
    alias run_reports runner
    def initialize(client)
      super
      @reports, @runner, @mailing_jobs = Reports.new(client), Runner.new(client), MailingJobs.new(client)
    end
  end
end
