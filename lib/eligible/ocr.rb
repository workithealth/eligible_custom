module Eligible
  class Ocr < APIResource
    def self.setup_file(params)
      file = Util.value(params, :file)
      params[:file] = File.new(file, 'rb') if file.is_a?(String)
    end

    def self.post(params, opts = {})
      setup_file(params)
      send_request :post, '/card_scans.json', params, opts
    end

    private_class_method :setup_file
  end
end
