# frozen_string_literal: true

module Eligible
  module V1_0
    class Estimate < RestAPIBase
      ENDPOINT_NAME = 'estimates'.freeze

      def self.process(id, opts = {})
        send_request :post, "/#{endpoint_name}/#{object_id(id)}/process", rest_api_params(id), opts.merge(required_params: [:id])
      end

      def self.reestimate(id, opts = {})
        send_request :post, "/#{endpoint_name}/#{object_id(id)}/reestimate", rest_api_params(id), opts.merge(required_params: [:id])
      end

      def self.convert(id, opts = {})
        send_request :post, "/#{endpoint_name}/#{object_id(id)}/convert", rest_api_params(id), opts.merge(required_params: [:id])
      end

      def self.update(_params, _opts = {})
        fail NotImplementedError, "Not an allowed operation for this endpoint"
      end

      def self.delete(_params, _opts = {})
        fail NotImplementedError, "Not an allowed operation for this endpoint"
      end
    end
  end
end
