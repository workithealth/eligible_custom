module Eligible
  class EligibleError < StandardError
    attr_reader :message
    attr_reader :http_status
    attr_reader :http_body
    attr_reader :json_body
    attr_reader :errors

    def initialize(message = nil, http_status = nil, http_body = nil, json_body = nil)
      @message = message
      @http_status = http_status
      @http_body = http_body
      @json_body = json_body
      @errors = (@json_body || {}).fetch(:errors, [])
    end

    def to_s
      status_string = @http_status.nil? ? '' : "(Status #{@http_status}) "
      json_errors = errors.presence || (json_body&.key?(:error) ? [json_body] : [])
      "#{status_string}#{@message}: #{json_errors.to_json}"
    end
  end
end
