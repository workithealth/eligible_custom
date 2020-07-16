module Eligible
  class Payment < APIResource
    def self.get(params, opts = {})
      send_request :get, '/payment/status.json', params, opts
    end

    def self.batch(params, opts = {})
      send_request :get, '/batch/payment/status.json', params, opts
    end
  end
end
