module Eligible
  class ReceivedPdf < APIResource
    def self.received_pdf_url(params)
      enrollment_npi_id = Util.value(params, :enrollment_npi_id)
      "/enrollment_npis/#{enrollment_npi_id}/received_pdf"
    end

    def self.get(params, opts = {})
      send_request :get, received_pdf_url(params), params, opts.merge(required_params: [:enrollment_npi_id])
    end

    def self.download(params, opts = {})
      enrollment_npi_id = Util.value(params, :enrollment_npi_id)
      require_param(enrollment_npi_id, 'Enrollment Npi id')
      params[:format] = 'x12'
      headers = opts.clone
      api_key = headers.delete(:api_key)
      response = Eligible.request(:get, "/enrollment_npis/#{params[:enrollment_npi_id]}/received_pdf/download", api_key, params, headers)[0]
      filename = params[:filename] || '/tmp/received_pdf.pdf'
      file = File.new(filename, 'w')
      file.write response
      file.close
      "PDF file stored at #{filename}"
    end
  end
end
