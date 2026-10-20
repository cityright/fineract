# frozen_string_literal: true

# rubocop:disable all
module Fineract
  class Organization < Resource
    class Staff < Resource
      def list(office_id: nil, staff_in_office_hierarchy: nil, loan_officers_only: nil, status: nil)
        call(:retrieve_all_staff, query: { "officeId" => office_id, "staffInOfficeHierarchy" => staff_in_office_hierarchy, "loanOfficersOnly" => loan_officers_only, "status" => status }.compact)
      end
      def create(**attributes)
        Contracts::Organization.staff_create(attributes)
        call(:create_staff, body: wire_keys(attributes))
      rescue ValidationError => e
        Failure.new(e)
      end
      def download_template(office_id: nil, date_format: nil) = call(:get_bulk_template_staff, query: { "officeId" => office_id, "dateFormat" => date_format }.compact)
      def upload_template(uploaded_input_stream:, locale: nil, date_format: nil) = call(:post_template, body: { "uploadedInputStream" => uploaded_input_stream, "locale" => locale, "dateFormat" => date_format }.compact, request_type: "multipart/form-data")
      def retrieve(staff_id) = safe_call { call(:retrieve_one_staff, path: { staffId: id!(staff_id, "staff_id") }) }
      def update(staff_id, **attributes) = safe_call { call(:update_staff, path: { staffId: id!(staff_id, "staff_id") }, body: wire_keys(attributes)) }
    end

    class Holidays < Resource
      def list(office_id: nil, from_date: nil, to_date: nil, locale: nil, date_format: nil) = call(:retrieve_all_holidays, query: { "officeId" => office_id, "fromDate" => from_date, "toDate" => to_date, "locale" => locale, "dateFormat" => date_format }.compact)
      def create(**attributes) = call(:create_holiday, body: wire_keys(attributes))
      def template = call(:retrieve_repayment_schedule_updation_tye_options)
      def retrieve(holiday_id) = safe_call { call(:retrieve_one_holiday, path: { holidayId: id!(holiday_id, "holiday_id") }) }
      def update(holiday_id, **attributes) = safe_call { call(:update_holiday, path: { holidayId: id!(holiday_id, "holiday_id") }, body: wire_keys(attributes)) }
      def delete(holiday_id) = safe_call { call(:delete_holiday, path: { holidayId: id!(holiday_id, "holiday_id") }) }
      def command(holiday_id, command: nil, **attributes) = safe_call { call(:handle_commands_holiday, path: { holidayId: id!(holiday_id, "holiday_id") }, query: { "command" => command }.compact, body: wire_keys(attributes)) }
    end

    class WorkingDays < Resource
      def list = call(:retrieve_all_working_days)
      def template = call(:retrieve_template_working_days)
      def update(extend_term_for_daily_repayments: nil, extend_term_for_repayments_on_holidays: nil, recurrence: nil, repayment_reschedule_type: nil) = call(:update_working_day, body: wire_keys(extend_term_for_daily_repayments: extend_term_for_daily_repayments, extend_term_for_repayments_on_holidays: extend_term_for_repayments_on_holidays, recurrence: recurrence, repayment_reschedule_type: repayment_reschedule_type))
    end

    class Currencies < Resource
      def list = call(:retrieve_currencies)
      def update(currencies:) = call(:update_currencies, body: { "currencies" => currencies })
    end

    class Funds < Resource
      def list = call(:retrieve_funds)
      def create(name:, external_id: nil) = call(:create_fund, body: { "name" => name, "externalId" => external_id }.compact)
      def retrieve(fund_id) = safe_call { call(:retrieve_fund, path: { fundId: id!(fund_id, "fund_id") }) }
      def update(fund_id, name:, external_id: nil) = safe_call { call(:update_fund, path: { fundId: id!(fund_id, "fund_id") }, body: { "name" => name, "externalId" => external_id }.compact) }
    end

    class Charges < Resource
      def list = call(:retrieve_all_charges)
      def create(**attributes) = call(:create_charge, body: wire_keys(attributes))
      def template(charge_applies_to: nil, charge_time_type: nil) = call(:retrieve_template_charge, query: { "chargeAppliesTo" => charge_applies_to, "chargeTimeType" => charge_time_type }.compact)
      def retrieve(charge_id) = safe_call { call(:retrieve_one_charge, path: { chargeId: id!(charge_id, "charge_id") }) }
      def update(charge_id, **attributes) = safe_call { call(:update_charge, path: { chargeId: id!(charge_id, "charge_id") }, body: wire_keys(attributes)) }
      def delete(charge_id) = safe_call { call(:delete_charge, path: { chargeId: id!(charge_id, "charge_id") }) }
    end

    class Codes < Resource
      def list = call(:retrieve_all_codes)
      def create(name:) = call(:create_code, body: { "name" => name })
      def retrieve(code_id) = safe_call { call(:retrieve_one_code, path: { codeId: id!(code_id, "code_id") }) }
      def retrieve_by_name(code_name) = call(:retrieve_one_code_by_name, path: { codeName: code_name })
      def update(code_id, name:) = safe_call { call(:update_code, path: { codeId: id!(code_id, "code_id") }, body: { "name" => name }) }
      def delete(code_id) = safe_call { call(:delete_code, path: { codeId: id!(code_id, "code_id") }) }
      def code_values(code_id) = safe_call { call(:retrieve_all_code_values, path: { codeId: id!(code_id, "code_id") }) }
      def create_code_value(code_id, **attributes) = safe_call { call(:create_code_value, path: { codeId: id!(code_id, "code_id") }, body: wire_keys(attributes)) }
      def retrieve_code_value(code_id, code_value_id) = safe_call { call(:retrieve_code_value, path: { codeId: id!(code_id, "code_id"), codeValueId: id!(code_value_id, "code_value_id") }) }
      def update_code_value(code_id, code_value_id, **attributes) = safe_call { call(:update_code_value, path: { codeId: id!(code_id, "code_id"), codeValueId: id!(code_value_id, "code_value_id") }, body: wire_keys(attributes)) }
      def delete_code_value(code_id, code_value_id) = safe_call { call(:delete_code_value, path: { codeId: id!(code_id, "code_id"), codeValueId: id!(code_value_id, "code_value_id") }) }
      def code_values_by_name(code_name) = call(:retrieve_all_code_values_by_code_name, path: { codeName: code_name })
      def create_code_value_by_name(code_name, **attributes) = call(:create_code_value_by_code_name, path: { codeName: code_name }, body: wire_keys(attributes))
      def retrieve_code_value_by_name(code_name, code_value_id) = safe_call { call(:retrieve_code_value_1, path: { codeName: code_name, codeValueId: id!(code_value_id, "code_value_id") }) }
      def update_code_value_by_name(code_name, code_value_id, **attributes) = safe_call { call(:update_code_value_by_code_name, path: { codeName: code_name, codeValueId: id!(code_value_id, "code_value_id") }, body: wire_keys(attributes)) }
      def delete_code_value_by_name(code_name, code_value_id) = safe_call { call(:delete_code_value_1, path: { codeName: code_name, codeValueId: id!(code_value_id, "code_value_id") }) }
    end

    attr_reader :staff, :holidays, :working_days, :currencies, :funds, :charges, :codes
    def initialize(client)
      super
      @staff, @holidays, @working_days = Staff.new(client), Holidays.new(client), WorkingDays.new(client)
      @currencies, @funds, @charges, @codes = Currencies.new(client), Funds.new(client), Charges.new(client), Codes.new(client)
    end
  end
end
# rubocop:enable all
