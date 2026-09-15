# frozen_string_literal: true

module Fineract
  # A client with an immutable, independently validated configuration.
  class Client
    attr_reader :configuration, :transport, :security_administration, :platform_administration, :organization,
                :fixed_deposits, :recurring_deposits, :clients, :groups, :centers, :collection_sheets, :offices, :loans, :accounting, :loan_products, :shares, :account_transfers, :reporting, :search

    def initialize(**options)
      @configuration = Configuration.new(Fineract.config.to_h.merge(options))
      @transport = Transport.new(@configuration)
      @security_administration = SecurityAdministration.new(self)
      @platform_administration = PlatformAdministration.new(self)
      @organization = Organization.new(self)
      @fixed_deposits = TermDeposits.new(self, "Fixed")
      @recurring_deposits = TermDeposits.new(self, "Recurring")
      @clients = Clients.new(self)
      @groups = Groups.new(self)
      @centers = Centers.new(self)
      @collection_sheets = CollectionSheets.new(self)
      @offices = Offices.new(self)
      @loans = Loans.new(self)
      @accounting = Accounting.new(self)
      @loan_products = LoanProducts.new(self)
      @shares = Shares.new(self)
      @account_transfers = AccountTransfers.new(self)
      @reporting = Reporting.new(self)
      @search = Search.new(self)
      @provisioning = Provisioning.new(self)
      @taxes = Taxes.new(self)
      @payment_types = PaymentTypes.new(self)
      @floating_rates = FloatingRates.new(self)
      @rates = Rates.new(self)
      @interest_rate_charts = InterestRateCharts.new(self)
    end

    alias security security_administration
    alias administration platform_administration
    alias org organization
    alias fixed_deposit fixed_deposits
    alias recurring_deposit recurring_deposits
    %i[users roles permissions password_preferences two_factor].each do |name|
      define_method(name) { security_administration.public_send(name) }
    end
    %i[global_configuration external_services cache hooks account_number_formats scheduler_jobs audits maker_checker batch_requests notifications scheduler].each do |name|
      define_method(name) { platform_administration.public_send(name) }
    end

    def request(...)
      transport.request(...)
    end

    def call(operation_name, path: {}, query: {}, headers: {}, body: nil, request_type: nil, response_type: nil, idempotent: nil, idempotency_key: nil, path_params: nil, header: nil)
      operation = OperationCatalog.default.fetch(operation_name)
      path = path_params unless path_params.nil?
      headers = header unless header.nil?
      validate_inputs!(operation, path, query, headers, body)
      request_headers = headers.dup
      request_headers["Accept"] ||= operation.response_media_types.first if operation.response_media_types.any?
      transport.request(operation.method, operation.path, path_params: path, query: query, headers: request_headers, body: body, request_type: request_type || operation.request_media_types.first || :json, response_type: response_type || operation.response_media_types.first, idempotent: idempotent, idempotency_key: idempotency_key)
    rescue KeyError
      Failure.new(UnknownOperationError.new("unknown Fineract operation: #{operation_name.inspect}"))
    rescue ValidationError => e
      Failure.new(e)
    rescue ArgumentError, TypeError => e
      Failure.new(ValidationError.new(e.message, details: e))
    end

    %i[get post put patch delete].each do |verb|
      define_method(verb) { |path, **options| transport.public_send(verb, path, **options) }
    end

    private

    def validate_inputs!(operation, path, query, headers, body)
      validate_hash!(path, "path"); validate_hash!(query, "query"); validate_hash!(headers, "headers")
      validate_parameters!(operation.path_parameters, path); validate_parameters!(operation.query_parameters, query); validate_parameters!(operation.header_parameters, headers)
      raise ValidationError, "missing required request body for #{operation.name}" if operation.request_required && body.nil?
      validate_schema!(operation.request_schema, body) if body && operation.request_schema && operation.name != "transaction"
    end

    def validate_hash!(value, name)
      raise ValidationError, "#{name} must be a Hash" unless value.is_a?(Hash)
    end

    def validate_parameters!(parameters, values)
      parameters.each do |parameter|
        name = parameter.fetch("name")
        unless !parameter["required"] || values.key?(name) || values.key?(name.to_sym)
          raise ValidationError, "missing required #{parameter.fetch("in")} parameter: #{name}"
        end
        value = values.key?(name) ? values[name] : values[name.to_sym]
        validate_schema!(parameter["schema"], value) if value && parameter["schema"]
      end
    end

    def validate_schema!(schema, value)
      return if schema.nil? || value.nil?
      case schema["type"]
      when "object"
        raise ValidationError, "expected object value" unless value.is_a?(Hash)
        Array(schema["required"]).each { |name| raise ValidationError, "missing required body field: #{name}" unless value.key?(name) || value.key?(name.to_sym) }
      when "array" then raise ValidationError, "expected array value" unless value.is_a?(Array)
      when "integer" then raise ValidationError, "expected integer value" unless value.is_a?(Integer)
      when "number" then raise ValidationError, "expected numeric value" unless value.is_a?(Numeric)
      when "boolean" then raise ValidationError, "expected boolean value" unless [true, false].include?(value)
      when "string" then raise ValidationError, "expected string value" unless value.is_a?(String)
      end
    end
  end
end
