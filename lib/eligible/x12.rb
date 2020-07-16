module Eligible
  class X12 < APIResource
    def self.post(params, opts = {})
      params[:format] = 'x12'
      send_request :post, '/x12', params, opts
    end
  end
end
