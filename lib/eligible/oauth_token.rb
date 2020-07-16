# frozen_string_literal: true

module Eligible
  class OauthToken < APIResource
    def self.post(params, opts = {})
      send_request :post, '/oauth/token', params, opts
    end
  end
end
