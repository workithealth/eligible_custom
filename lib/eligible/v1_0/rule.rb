# frozen_string_literal: true

module Eligible
  module V1_0
    class Rule < RestAPIBase
      ENDPOINT_NAME = 'rules'.freeze

      def self.validate(params, opts = {})
        send_request :post, "/#{endpoint_name}/validate", rest_api_params(params), opts
      end
    end
  end
end
