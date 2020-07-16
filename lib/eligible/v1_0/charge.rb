# frozen_string_literal: true

module Eligible
  module V1_0
    class Charge < RestAPIBase
      ENDPOINT_NAME = 'charges'.freeze

      def self.delete(_params, _opts = {})
        fail NotImplementedError, "Not an allowed operation for this endpoint"
      end
    end
  end
end
