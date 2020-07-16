module Eligible
  class Customer < APIResource
    def self.get(params, opts = {})
      send_request :get, api_url('customers', params, :customer_id), params, opts.merge(required_params: [:customer_id])
    end

    def self.post(params, opts = {})
      send_request :post, api_url('customers'), params, opts
    end

    def self.update(params, opts = {})
      send_request :put, api_url('customers', params, :customer_id), params, opts.merge(required_params: [:customer_id])
    end

    def self.all(params, opts = {})
      send_request :get, api_url('customers'), params, opts
    end
  end
end
