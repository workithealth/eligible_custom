# frozen_string_literal: true

module Eligible
  module V1_0
    class EstimateServiceLine < RestAPIBase
      ENDPOINT_NAME = 'estimate_service_lines'.freeze
    end

    def self.update(_params, _opts = {})
      fail NotImplementedError, "Not an allowed operation for this endpoint"
    end

    def self.delete(_params, _opts = {})
      fail NotImplementedError, "Not an allowed operation for this endpoint"
    end
  end
end
