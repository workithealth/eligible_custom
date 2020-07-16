module Eligible
  class APIResource < EligibleObject
    def self.class_name
      name.split('::').last
    end

    def self.api_url(base, params = nil, param_id = nil)
      if params.nil?
        "/#{base}"
      else
        id = Util.value(params, param_id)
        "/#{base}/#{id}"
      end
    end

    def self.url
      if self == APIResource
        fail NotImplementedError, 'APIResource is an abstract class.  You should perform actions on its subclasses (Plan, Service, etc.)'
      end
      "/#{CGI.escape(class_name.downcase)}/"
    end

    def self.endpoint_name
      self.const_get('ENDPOINT_NAME')
    end

    def self.require_param(value, name)
      fail ArgumentError, "#{name} of the #{class_name} is required" if value.nil? || (value.is_a?(String) && value.empty?)
    end

    def self.required_param_validation(params:, required_params:)
      return if required_params.nil? || !required_params.is_a?(Array)

      required_params.each do |required_param_name|
        required_param = Util.value(params, required_param_name)
        require_param(required_param, required_param_name)
      end
    end

    def self.rest_api_params(id_or_params)
      id_or_params.is_a?(Hash) ? id_or_params : { id: id_or_params }
    end

    def self.send_request(method, url, params, opts)
      headers = opts.clone
      client_secret = headers.delete(:client_secret)
      api_key = headers.delete(:api_key)
      api_key = client_secret unless client_secret.nil?

      required_param_validation(params: params, required_params: headers.delete(:required_params))

      # Here rest_api_version is related to New REST API Endpoints
      params = self.const_defined?(:REST_API_VERSION) ? params.merge(rest_api_version: self::REST_API_VERSION) : params
      response, api_key = Eligible.request(method, url, api_key, params, headers)
      Util.convert_to_eligible_object(response, api_key)
    end
  end
end
