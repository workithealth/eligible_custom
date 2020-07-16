# frozen_string_literal: true

module Eligible
  module V1_0
    class RestAPIBase < APIResource
      REST_API_VERSION = '1.0'.freeze

      def self.retrieve(id, opts = {})
        send_request :get, api_url(endpoint_name, rest_api_params(id), :id), rest_api_params(id), opts.merge(required_params: [:id])
      end

      def self.create(params, opts = {})
        send_request :post, api_url(endpoint_name), rest_api_params(params), opts
      end

      def self.update(params, opts = {})
        send_request :put, api_url(endpoint_name, rest_api_params(params), :id), rest_api_params(params), opts.merge(required_params: [:id])
      end

      def self.list(params, opts = {})
        send_request :get, api_url(endpoint_name), rest_api_params(params), opts
      end

      def self.delete(id, opts = {})
        send_request :delete, api_url(endpoint_name, rest_api_params(id), :id), rest_api_params(id), opts.merge(required_params: [:id])
      end

      private

      def self.object_id(id_or_params)
        id_or_params.is_a?(Hash) ? Util.value(id_or_params, :id) : id_or_params
      end

      def self.fee_refund_id(params)
        Util.value(rest_api_params(params), :id)
      end

      def self.fee_url(params)
        fee_id = Util.value(rest_api_params(params), :fee)
        "/fees/#{fee_id}"
      end
    end
  end
end
