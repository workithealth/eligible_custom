module Eligible
  class ProviderModel < APIResource
    def self.get(params, opts = {})
      send_request :get, '/provider_models.json', params, opts
    end
  end
end
