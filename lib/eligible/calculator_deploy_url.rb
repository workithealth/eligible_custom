module Eligible
  class CalculatorDeployUrl < APIResource
    def self.fetch_or_create(params, opts = {})
      send_request :get, '/calculator_deploy_urls.json', params, opts
    end
  end
end
