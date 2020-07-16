# frozen_string_literal: true

module Eligible
  module V1_0
    class File < RestAPIBase
      ENDPOINT_NAME = 'files'.freeze

      def self.update(_params, _opts = {})
        fail NotImplementedError, "Not an allowed operation for this endpoint"
      end

      def self.delete(_params, _opts = {})
        fail NotImplementedError, "Not an allowed operation for this endpoint"
      end
    end
  end
end
