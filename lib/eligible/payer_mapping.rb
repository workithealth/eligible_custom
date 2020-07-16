# frozen_string_literal: true

module Eligible
  class PayerMapping < APIResource
    def self.mapper(params, opts = {})
      send_request :post, '/payer_mapping/mapper', params, opts
    end

    def self.mapper_batch(params, opts = {})
      send_request :post, '/payer_mapping/mapper/batch', params, opts
    end

    def self.search(params, opts = {})
      send_request :post, '/payer_mapping/search', params, opts
    end

    def self.search_batch(params, opts = {})
      send_request :post, '/payer_mapping/search/batch', params, opts
    end

    def self.normalize(params, opts = {})
      send_request :post, '/payer_mapping/normalize', params, opts
    end

    def self.normalize_batch(params, opts = {})
      send_request :post, '/payer_mapping/normalize/batch', params, opts
    end

    def self.normalize_cased(params, opts = {})
      send_request :post, '/payer_mapping/normalize_cased', params, opts
    end

    def self.normalize_cased_batch(params, opts = {})
      send_request :post, '/payer_mapping/normalize_cased/batch', params, opts
    end
  end
end
