module Eligible
  class Icd < APIResource

    def self.list(params, opts = {})
      send_request :get, "/icds/#{Util.value(params, :type)}", params, opts
    end

    def self.describe(params, opts = {})
      send_request :get, "/icds/#{Util.value(params, :type)}/describe/#{Util.value(params, :code)}", params, opts
    end

    def self.crosswalk(params, opts = {})
      send_request :get, "/icds/#{Util.value(params, :type)}/crosswalk/#{Util.value(params, :code)}", params, opts
    end
  end
end
