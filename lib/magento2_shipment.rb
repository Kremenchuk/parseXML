module Magento2
  class Shipment


    def self.shipment(shipment_attr, token_key)
      # salesShipmentRepositoryV1
      begin
        shipment = JSON.parse(RestClient.post "http://maxus.beta.qpard.com/index.php/rest/V1/shipment",
                                              shipment_attr.to_json, {:Authorization => "Bearer #{token_key}", :content_type => :json, :accept => :json})
      rescue => e
        a = e
      end
      return shipment
    end
  end
end
