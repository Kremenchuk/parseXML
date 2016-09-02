module Magento2
  class Cart


    def self.create_cart(token_key)
      # quoteCartManagementV1
      begin
        cart = RestClient.post "http://maxus.beta.qpard.com/index.php/rest/V1/customers/1/carts", "",
                               {:Authorization => "Bearer #{token_key}", :content_type => :json, :accept => :json}
      rescue => e
        a = e
      end
      return cart.to_s.gsub('"', '')
    end



    def self.add_products_to_cart(cart_id, product_attr, token_key)
      # quoteCartItemRepositoryV1
       begin
        RestClient.post "http://maxus.beta.qpard.com/index.php/rest/V1/carts/#{cart_id}/items",
                        product_attr.to_json, {:Authorization => "Bearer #{token_key}", :content_type => :json, :accept => :json}
      rescue => e
        a = e
      end
    end


    def self.add_billing_address(cart_id, billing_attr, token_key)
      # quoteBillingAddressManagementV1
      begin
        RestClient.post "http://maxus.beta.qpard.com/index.php/rest/V1/carts/#{cart_id}/billing-address",
                        billing_attr.to_json, {:Authorization => "Bearer #{token_key}", :content_type => :json, :accept => :json}
      rescue => e
        a = e
      end
    end



    def self.add_shipping_address(cart_id, shipping_attr, token_key)
      # checkoutShippingInformationManagementV1
      begin
        RestClient.post "http://maxus.beta.qpard.com/index.php/rest/V1/carts/#{cart_id}/shipping-information",
                        shipping_attr.to_json, {:Authorization => "Bearer #{token_key}", :content_type => :json, :accept => :json}
      rescue => e
        a = e
      end
    end



    def self.add_payment_method(cart_id, payment_method_attr, token_key)
      # quotePaymentMethodManagementV1

      begin
        RestClient.put "http://maxus.beta.qpard.com/index.php/rest/V1/carts/#{cart_id}/selected-payment-method",
                       payment_method_attr.to_json, {:Authorization => "Bearer #{token_key}", :content_type => :json, :accept => :json}
      rescue => e
        a = e
      end
    end





  end
end