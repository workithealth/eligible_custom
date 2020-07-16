module Eligible
  class Enrollment < APIResource
    def self.get(params, opts = {})
      send_request :get, api_url('enrollment_npis', params, :enrollment_npi_id), params, opts.merge(required_params: [:enrollment_npi_id])
    end

    def self.list(params, opts = {})
      send_request :get, api_url('enrollment_npis'), params, opts
    end

    def self.post(params, opts = {})
      send_request :post, api_url('enrollment_npis'), params, opts
    end

    def self.update(params, opts = {})
      send_request :put, api_url('enrollment_npis', params, :enrollment_npi_id), params, opts.merge(required_params: [:enrollment_npi_id])
    end

    def enrollment_npis
      values.first[:enrollment_npis]
    end
  end
end
