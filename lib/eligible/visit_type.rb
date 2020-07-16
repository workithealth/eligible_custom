module Eligible
  class VisitType < APIResource
    def self.list(params, opts = {})
      send_request :get, '/visit_types.json', params, opts
    end

    def self.insurance_company_ids(params, opts = {})
      send_request :get, '/visit_types/insurance_company_ids.json', params, opts
    end
  end
end
