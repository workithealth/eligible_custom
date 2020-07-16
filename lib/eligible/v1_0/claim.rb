# frozen_string_literal: true

module Eligible
  module V1_0
    class Claim < RestAPIBase
      ENDPOINT_NAME = 'claims'.freeze

      def self.delete(_params, _opts = {})
        fail NotImplementedError, "Not an allowed operation for this endpoint"
      end

      def self.submit(id, opts = {})
        send_request :post, "/#{endpoint_name}/#{object_id(id)}/submit", rest_api_params(id), opts.merge(required_params: [:id])
      end

      def self.correct(id, opts = {})
        send_request :post, "/#{endpoint_name}/#{object_id(id)}/correct", rest_api_params(id), opts.merge(required_params: [:id])
      end

      def self.cancel(id, opts = {})
        send_request :delete, "/#{endpoint_name}/#{object_id(id)}/cancel", rest_api_params(id), opts.merge(required_params: [:id])
      end
    end
  end
end
