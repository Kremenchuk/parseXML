module Magento2
  class Order

    def self.order(cart_id, token_key)
      begin
        order_id = RestClient.put "http://maxus.beta.qpard.com/index.php/rest/V1/carts/#{cart_id}/order", "",
                                  {:Authorization => "Bearer #{token_key}", :content_type => :json, :accept => :json}
      rescue RestClient::ExceptionWithResponse => e
        a = e
      end
      return order_id.to_s.gsub('"', '')
    end

  end
end