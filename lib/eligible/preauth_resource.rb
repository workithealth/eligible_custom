module Eligible
  class PreauthResource < CoverageResource
    def self.inquiry(params, opts = {})
      get(params, opts)
    end

    def self.create(params, opts = {})
      post(params, opts)
    end
  end
end
