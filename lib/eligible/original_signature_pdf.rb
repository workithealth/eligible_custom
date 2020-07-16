module Eligible
  class OriginalSignaturePdf < APIResource
    def self.original_signature_pdf_url(params)
      enrollment_npi_id = Util.value(params, :enrollment_npi_id)
      "/enrollment_npis/#{enrollment_npi_id}/original_signature_pdf"
    end

    def self.get(params, opts = {})
      send_request :get, original_signature_pdf_url(params), params, opts.merge(required_params: [:enrollment_npi_id])
    end

    def self.setup_file(params)
      file = Util.value(params, :file)
      params[:file] = File.new(file, 'rb') if file.is_a?(String)
    end

    def self.post(params, opts = {})
      setup_file(params)
      send_request :post, original_signature_pdf_url(params), params, opts.merge(required_params: [:enrollment_npi_id])
    end

    def self.update(params, opts = {})
      setup_file(params)
      send_request :put, original_signature_pdf_url(params), params, opts.merge(required_params: [:enrollment_npi_id])
    end

    def self.delete(params, opts = {})
      send_request :delete, original_signature_pdf_url(params), params, opts.merge(required_params: [:enrollment_npi_id])
    end

    def self.download(params, opts = {})
      enrollment_npi_id = Util.value(params, :enrollment_npi_id)
      require_param(enrollment_npi_id, 'Enrollment Npi id')
      params[:format] = 'x12'
      headers = opts.clone
      api_key = headers.delete(:api_key)
      response = Eligible.request(:get, "/enrollment_npis/#{enrollment_npi_id}/original_signature_pdf/download", api_key, params, headers)[0]
      filename = params[:filename] || '/tmp/original_signature_pdf.pdf'
      file = File.new(filename, 'w')
      file.write response
      file.close
      "PDF file stored at #{filename}"
    end
  end
end
