module Eligible
  class RiskAssessment < APIResource
    def self.criteria(params, opts = {})
      send_request :get, '/risk_assessments/criteria.json', params, opts
    end

    def self.cost_estimate(params, opts = {})
      send_request :get, '/risk_assessments/cost_estimates.json', params, opts
    end

    def self.fetch(params, opts = {})
      send_request :get, '/risk_assessments/fetch.json', params, opts
    end
  end
end
