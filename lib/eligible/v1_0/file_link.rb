# frozen_string_literal: true

module Eligible
  module V1_0
    class FileLink < RestAPIBase
      ENDPOINT_NAME = 'file_links'.freeze

      def self.delete(_params, _opts = {})
        fail NotImplementedError, "Not an allowed operation for this endpoint"
      end
    end
  end
end
