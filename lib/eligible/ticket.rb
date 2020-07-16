module Eligible
  class Ticket < APIResource
    def self.ticket_url(params = nil, comments = false)
      if params.nil?
        '/tickets'
      else
        id = Util.value(params, :id)
        if comments
          "/tickets/#{id}/comments"
        else
          "/tickets/#{id}"
        end
      end
    end

    def self.create(params, opts = {})
      send_request :post, ticket_url, params, opts
    end

    def self.comments(params, opts = {})
      send_request :post, ticket_url(params, true), params, opts.merge(required_params: [:id])
    end

    def self.all(params, opts = {})
      send_request :get, ticket_url, params, opts
    end

    def self.get(params, opts = {})
      send_request :get, ticket_url(params), params, opts.merge(required_params: [:id])
    end

    def self.delete(params, opts = {})
      send_request :delete, ticket_url(params), params, opts.merge(required_params: [:id])
    end

    def self.update(params, opts = {})
      send_request :put, ticket_url(params), params, opts.merge(required_params: [:id])
    end
  end
end
