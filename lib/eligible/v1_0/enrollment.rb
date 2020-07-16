# frozen_string_literal: true

module Eligible
  module V1_0
    class Enrollment < RestAPIBase
      ENDPOINT_NAME = 'enrollments'.freeze

      def self.summary(params, opts = {})
        send_request :get, "/#{endpoint_name}/summary", rest_api_params(params), opts
      end

      def self.escalate(id, opts = {})
        send_request :post, "/#{endpoint_name}/#{object_id(id)}/escalate", rest_api_params(id), opts.merge(required_params: [:id])
      end
    end
  end
end
