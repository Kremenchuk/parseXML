module Magento2
  class Invoice

    def self.invoice(invoice_attr, token_key)
      # salesInvoiceRepositoryV1
      begin
        invoice = JSON.parse(RestClient.post "http://maxus.beta.qpard.com/index.php/rest/V1/invoices",
                                             invoice_attr.to_json, {:Authorization => "Bearer #{token_key}", :content_type => :json, :accept => :json})
      rescue => e
        a = e
      end
      return invoice['entity_id']
    end

  end
end
