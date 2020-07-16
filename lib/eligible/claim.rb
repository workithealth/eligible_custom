module Eligible
  class Claim < APIResource
    def self.ack(params, opts = {})
      reference_id = Util.value(params, :reference_id)
      send_request :get, "/claims/#{reference_id}/acknowledgements.json", params, opts.merge(required_params: [:reference_id])
    end

    def self.post(params, opts = {})
      send_request :post, '/claims.json', params, opts
    end

    def self.acks(params, opts = {})
      send_request :get, '/claims/acknowledgements.json', params, opts
    end

    def self.payment_report(params, opts = {})
      reference_id = Util.value(params, :reference_id)
      require_param(reference_id, 'Reference id')
      id = Util.value(params, :id)
      url = id.nil? ? "/claims/#{reference_id}/payment_reports" : "/claims/#{reference_id}/payment_reports/#{id}"
      send_request :get, url, params, opts
    end

    def self.payment_reports(params, opts = {})
      send_request :get, '/claims/payment_reports.json', params, opts
    end
  end
end
