# frozen_string_literal: true

module Eligible
  module V1_0
    class PatientStatementServiceLine < RestAPIBase
      ENDPOINT_NAME = 'patient_statement_service_lines'.freeze

      def self.update(_params, _opts = {})
        fail NotImplementedError, "Not an allowed operation for this endpoint"
      end
    end
  end
end
