require 'openssl'

module Eligible
  class PublicKey < APIResource
    def self.get(params, opts = {})
      send_request :get, api_url('public_keys', params, :key_id), params, opts.merge(required_params: [:key_id])
    end

    def self.post(params, opts = {})
      send_request :post, api_url('public_keys'), params, opts
    end

    def self.activate(params, opts = {})
      key_id = Util.value(params, :key_id)
      send_request :get, "/public_keys/#{key_id}/activate", params, opts.merge(required_params: [:key_id])
    end

    def self.all(params, opts = {})
      send_request :get, api_url('public_keys'), params, opts
    end

    def self.create_pair
      rsa_key = OpenSSL::PKey::RSA.new(4096)
      [ rsa_key.to_pem, rsa_key.public_key.to_pem ]
    end
  end
end
