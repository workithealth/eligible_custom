require 'cgi'
require 'set'
require 'rubygems'
require 'openssl'
require 'net/https'

require 'rest_client'
require 'multi_json'

require 'eligible/version'
require 'eligible/encryptor'
require 'eligible/util'
require 'eligible/json'
require 'eligible/eligible_object'
require 'eligible/api_resource'
require 'eligible/coverage_resource'
require 'eligible/demographic'
require 'eligible/claim'
require 'eligible/enrollment'
require 'eligible/coverage'
require 'eligible/payment'
require 'eligible/x12'
require 'eligible/medicare'
require 'eligible/ticket'
require 'eligible/customer'
require 'eligible/ocr'
require 'eligible/original_signature_pdf'
require 'eligible/oauth_token'
require 'eligible/received_pdf'
require 'eligible/payer'
require 'eligible/payer_mapping'
require 'eligible/preauth_resource'
require 'eligible/precert'
require 'eligible/referral'
require 'eligible/public_key'
require 'eligible/lockbox'
require 'eligible/session_token'
require 'eligible/visit_type'
require 'eligible/provider_model'
require 'eligible/calculator_deploy_url'
require 'eligible/risk_assessment'
require 'eligible/icd'

# New REST API Endpoints
require 'eligible/v1_0/rest_api_base'
require 'eligible/v1_0/action'
require 'eligible/v1_0/attribute'
require 'eligible/v1_0/charge'
require 'eligible/v1_0/claim'
require 'eligible/v1_0/claim_service_line'
require 'eligible/v1_0/contract'
require 'eligible/v1_0/device'
require 'eligible/v1_0/discount'
require 'eligible/v1_0/enrollment'
require 'eligible/v1_0/estimate'
require 'eligible/v1_0/estimate_service_line'
require 'eligible/v1_0/fee'
require 'eligible/v1_0/fee_refund'
require 'eligible/v1_0/file'
require 'eligible/v1_0/file_link'
require 'eligible/v1_0/insurance_company'
require 'eligible/v1_0/insurance_company_alias'
require 'eligible/v1_0/insurance_policy'
require 'eligible/v1_0/patient_record'
require 'eligible/v1_0/patient_statement'
require 'eligible/v1_0/patient_statement_service_line'
require 'eligible/v1_0/payment_report'
require 'eligible/v1_0/patient_question'
require 'eligible/v1_0/patient_questionnaire'
require 'eligible/v1_0/product'
require 'eligible/v1_0/provider'
require 'eligible/v1_0/remark'
require 'eligible/v1_0/rule'
require 'eligible/v1_0/session'
require 'eligible/v1_0/transaction'
require 'eligible/v1_0/treatment'
require 'eligible/v1_0/value_list'
require 'eligible/v1_0/value_list_item'
require 'eligible/v1_0/verification'
require 'eligible/v1_0/reports/accuracy_stats'
require 'eligible/v1_0/reports/estimate_friction'
require 'eligible/v1_0/reports/in_scope_distribution'

# Errors
require 'eligible/errors/eligible_error'
require 'eligible/errors/api_connection_error'
require 'eligible/errors/authentication_error'
require 'eligible/errors/api_error'
require 'eligible/errors/invalid_request_error'

module Eligible
  @@api_key = nil
  @@test = false
  @@api_version = '1.5'
  @@api_base = "https://gds.eligibleapi.com/v#{@@api_version}"
  @@fingerprints = %w(a1cd762a9f4be0f3b6bdd6300e52c6ce8d7d67f5
                      36d6b6f98a2b9bcdf4321d1978553e23cf044b53
                      d93b7697100fe978ae0f78fbf2a2443cc1958ca3
                      896ce24f7a83eb656c040985fdb50ce39f90b813)
  @@eligible_account = nil
  @@eligible_account_id = nil

  def self.api_url(url = '', rest_api_version = nil)
    api_base = rest_api_version ? @@api_base.gsub(/v(\d).(\d)/, "v#{rest_api_version}") : @@api_base
    api_base + url.to_s
  end

  def self.eligible_account
    @@eligible_account
  end

  def self.eligible_account_id
    @@eligible_account_id
  end

  def self.eligible_account=(eligible_account)
    @@eligible_account = eligible_account
  end

  def self.eligible_account_id=(eligible_account_id)
    @@eligible_account_id = eligible_account_id
  end

  def self.api_key
    @@api_key
  end

  def self.api_key=(api_key)
    @@api_key = api_key
  end

  def self.api_base
    @@api_base
  end

  def self.api_base=(api_base)
    @@api_base = api_base
  end

  def self.test
    @@test ? 'true' : 'false'
  end

  def self.test=(is_test)
    @@test = is_test
  end

  def self.api_version=(version)
    @@api_version = version
  end

  def self.api_version
    @@api_version
  end

  def self.fingerprints
    @@fingerprints
  end

  def self.add_fingerprint(digest)
    $stderr.puts 'The embedded certificate fingerprint was modified. This should only be done if instructed to by eligible support staff'
    @@fingerprints << digest
  end

  def self.direct_response?(params)
    params[:format].is_a?(String) && params[:format].downcase == 'x12'
  end

  def self.test_key?(params)
    Util.key?(params, :test)
  end

  def self.api_key?(params)
    Util.key?(params, :api_key)
  end

  def self.rest_api_version?(params)
    Util.key?(params, :rest_api_version)
  end

  def self.request(method, url, api_key, params = {}, headers = {})
    session_token = Util.value(params, :session_token)
    api_key ||= @@api_key unless session_token
    test = self.test
    api_key = Util.value(params, :api_key) if api_key?(params)
    test = Util.value(params, :test) if test_key?(params)
    rest_api_version = Util.value(params, :rest_api_version) if rest_api_version?(params)
    basic_auth = true if rest_api_version?(params)

    fail AuthenticationError, 'No API key provided. (HINT: set your API key using "Eligible.api_key = <API-KEY>".' unless api_key || session_token

    lang_version = "#{RUBY_VERSION} p#{RUBY_PATCHLEVEL} (#{RUBY_RELEASE_DATE})"
    debug_info = {
      bindings_version: Eligible::VERSION,
      lang: 'ruby',
      lang_version: lang_version,
      platform: RUBY_PLATFORM,
      publisher: 'eligible',
      uname: uname
    }

    # Set request URL and Payload based on new and old endpoints version
    url, payload = generate_request_url_and_payload(
      method, url, params, { test: test, rest_api_version: rest_api_version, api_key: api_key, basic_auth: basic_auth },
    )

    # Set request Headers and Authorization based on new and old endpoints version
    headers = generate_request_headers(headers, debug_info, basic_auth, { api_key: api_key, session_token: session_token })

    opts = {
      method: method,
      url: url,
      headers: headers,
      open_timeout: 30,
      payload: payload,
      timeout: 80,
      ssl_verify_callback: verify_certificate,
      ssl_verify_callback_warnings: false
    }

    begin
      response = execute_request(opts)

    rescue SocketError => e
      handle_restclient_error(e)

    rescue NoMethodError => e
      # Work around RestClient bug
      raise unless e.message =~ /\WRequestFailed\W/

      e = APIConnectionError.new('Unexpected HTTP response code')
      handle_restclient_error(e)

    rescue RestClient::ExceptionWithResponse => e
      err_rcode = e.http_code
      err_rbody = e.http_body

      if err_rcode && err_rbody
        handle_api_error(err_rcode, err_rbody)
      else
        handle_restclient_error(e)
      end

    rescue RestClient::Exception, Errno::ECONNREFUSED => e
      handle_restclient_error(e)
    end

    rbody = response.body
    rcode = response.code

    begin
      # Would use :symbolize_names => true, but apparently there is
      # some library out there that makes symbolize_names not work.
      resp = direct_response?(params) ? rbody : Eligible::JSON.load(rbody)
    rescue MultiJson::DecodeError
      raise APIError.new("Invalid response object from API: #{rbody.inspect} (HTTP response code was #{rcode})", rcode, rbody)
    end

    resp = Util.symbolize_names(resp)
    return [ resp, api_key ]
  end

  def self.generate_request_url_and_payload(method, url, params, options)
    # GET requests, parameters on the query string
    # POST requests, parameters as json in the body
    url = api_url(url, options[:rest_api_version])
    # Used rest_api_version param only to identify new REST API version, and is not required to make calls for new REST api endpoints
    params.delete(:rest_api_version)
    case method.to_s.downcase.to_sym
    when :get, :head, :delete
      url = fetch_url_with_query_string(params, url, options)
      payload = nil
    else
      payload = request_payload(options, params)
    end

    [url, payload]
  end

  def self.fetch_url_with_query_string(params, url, options)
    url += options_query_string(options)
    return url unless params || params.count == 0

    query_string = params_query_string(params)
    url += options[:basic_auth] ? "?#{query_string}" : "&#{query_string}"
    url
  end

  def self.options_query_string(options)
    options[:basic_auth] ? '' : "?test=#{options[:test]}&api_key=#{options[:api_key]}"
  end

  def self.params_query_string(params)
    Util.flatten_params(params).collect { |key, value| "#{key}=#{Util.url_encode(value)}" }.join('&')
  end

  def self.request_payload(options, params)
    params.merge!('test' => options[:test], 'api_key' => options[:api_key]) unless options[:basic_auth]
    Util.key?(params, :file) ? params : Eligible::JSON.dump(params)
  end

  def self.generate_request_headers(headers, debug_info, basic_auth, auth_options)
    begin
      headers = { x_eligible_debuginfo: Eligible::JSON.dump(debug_info) }.merge(headers)
    rescue => e
      headers = {
        x_eligible_client_raw_user_agent: debug_info.inspect,
        error: "#{e} (#{e.class})"
      }.merge(headers)
    end

    headers = {
      user_agent: "eligible-ruby/#{Eligible::VERSION}",
      content_type: 'application/json'
    }.merge(headers)

    headers[:authorization] = authorization_header(basic_auth, auth_options)
    headers[:eligible_version] = api_version if api_version
    headers[:eligible_account] = eligible_account if eligible_account
    headers[:eligible_account_id] = eligible_account_id if eligible_account_id
    headers
  end

  def self.authorization_header(basic_auth, auth_options)
    # Using Bearer scheme for Session Token Auth for new REST API endpoints (v1.0)
    return "Bearer #{auth_options[:session_token]}" if basic_auth && auth_options[:session_token]

    # Using Basic Auth for new REST API endpoints (v1.0)
    basic_auth_token = Base64.strict_encode64("#{auth_options[:api_key]}:")
    "Basic #{basic_auth_token}" if basic_auth
  end

  def self.verify_certificate
    lambda do |preverify_ok, certificate_store|
      return true if test == 'true'
      return false unless preverify_ok
      received = certificate_store.chain.first
      return true unless received.to_der == certificate_store.current_cert.to_der
      valid_fingerprint?(received)
    end
  end

  def self.valid_fingerprint?(received)
    fingerprints.include?(OpenSSL::Digest::SHA1.hexdigest(received.to_der))
  end

  private

  def self.uname
    @@uname ||= RUBY_PLATFORM =~ /linux|darwin/i ? `uname -a 2>/dev/null`.strip : nil
  end

  def self.execute_request(opts)
    RestClient::Request.execute(opts)
  end

  def self.error_message(error, errors)
    message = compose_message_from_errors(errors)
    return message if message

    return compose_message_from_error(error)
  end

  def self.compose_message_from_errors(errors)
    return unless errors.is_a?(Array)

    return errors.first[:message] if errors.size == 1
    return errors.each_with_index.map { |error, index| "#{index + 1}. #{error[:message]}" }.join("\n")
  end

  def self.compose_message_from_error(error)
    return error.to_s unless error.is_a?(Hash)
    result = error[:details] || error[:reject_reason_description] || error
    return result.to_s
  end

  def self.handle_api_error(rcode, rbody)
    begin
      error_obj = Util.symbolize_names(Eligible::JSON.load(rbody))
      fail EligibleError unless error_obj.keys.any? { |k| [:error, :errors].include? k }
      error = error_obj[:error]
      errors = error_obj[:errors]

    rescue MultiJson::DecodeError, EligibleError
      raise APIError.new("Invalid response object from API: #{rbody.inspect} (HTTP response code was #{rcode})", rcode, rbody)
    end

    error_msg = error_message(error, errors)

    case rcode
    when 400, 404 then
      raise invalid_request_error(error_msg, rcode, rbody, error_obj)
    when 401
      raise authentication_error(error_msg, rcode, rbody, error_obj)
    else
      raise api_error(error_msg, rcode, rbody, error_obj)
    end
  end

  def self.invalid_request_error(error_msg, rcode, rbody, error_obj)
    InvalidRequestError.new(error_msg, rcode, rbody, error_obj)
  end

  def self.authentication_error(error_msg, rcode, rbody, error_obj)
    AuthenticationError.new(error_msg, rcode, rbody, error_obj)
  end

  def self.api_error(error_msg, rcode, rbody, error_obj)
    APIError.new(error_msg, rcode, rbody, error_obj)
  end

  def self.handle_restclient_error(e)
    case e
    when RestClient::ServerBrokeConnection, RestClient::RequestTimeout
      message = "Could not connect to Eligible (#{@@api_base}).  Please check your internet connection and try again."
    when RestClient::SSLCertificateNotVerified
      message = "Could not verify Eligible's SSL certificate."
    when SocketError
      message = 'Unexpected error communicating when trying to connect to Eligible.'
    else
      message = 'Unexpected error communicating with Eligible. If this problem persists, let us know at support@eligible.com.'
    end
    fail APIConnectionError, "#{message}\n\n(Network error: #{e.message})"
  end
end
