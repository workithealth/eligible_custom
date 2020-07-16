module Eligible
  class SessionToken < APIResource
    def self.create(params, opts = {})
      send_request :post, '/session_tokens/create.json', params, opts
    end

    def self.revoke(params, opts = {})
      send_request :post, '/session_tokens/revoke.json', params, opts
    end
  end
end
