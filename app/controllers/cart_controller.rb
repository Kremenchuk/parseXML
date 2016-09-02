class CartController < ApplicationController



  def crate_cart
    order_products = []
    invoice_info = {}


    billing_attr =
        {
            "address": {
                "country_id": "UA",       # id держави - міжнародне скорочення
                "street": [
                    "вул. Сагайдачного"
                ],
                "telephone": "0661234567",
                "postcode": "61002",
                "city": "Харків",
                "firstname": "Петро",
                "lastname": "Петров"
            },
            "useForShipping": true
        }

    shipping_attr =
        {
            "addressInformation":
                {
                    "shipping_address":
                        {
                            "country_id": "UA",
                            "street": [
                                "вул. Скоропадського"
                            ],
                            "telephone": "0661234567",
                            "postcode": "61002",
                            "city": "Харків",
                            "firstname": "Петро",
                            "lastname": "Петров"
                        },
                    "shipping_method_code": "freeshipping",
                    "shipping_carrier_code": "freeshipping"
                }
        }
    payment_method_attr =
        {
            "method": {
                "method": "checkmo"
            }
        }
    # Створення корзини
    cart_id = Magento2::Cart.create_cart(@token_key)

    product_attr = {
        "cartItem":
            {
                "sku": "2-CSDL-SN-1",
                "qty": 2,
                "name": "Cover SDL  Satin nickel (по 2 шт.)",
                "price": 31,
                "product_type": "simple",
                "quote_id": cart_id
            }
    }

    # Додавання товарів до корзини(додавати товар по одному)
    Magento2::Cart.add_products_to_cart(cart_id, product_attr, @token_key)

    # Додавання платіжної адреси корзини
    Magento2::Cart.add_billing_address(cart_id, billing_attr, @token_key)

    # Додавання адреси доставки корзини
    Magento2::Cart.add_shipping_address(cart_id, shipping_attr, @token_key)

    # Встановлення методу оплати корзини
    Magento2::Cart.add_payment_method(cart_id, payment_method_attr, @token_key)

    # Створення замовлення
    order_id = Magento2::Order.order(cart_id, @token_key)


    # salesOrderRepositoryV1
    begin
      order_items = JSON.parse(RestClient.get "http://maxus.beta.qpard.com/index.php/rest/V1/orders/#{order_id}",
                                              {:Authorization => "Bearer #{@token_key}", :content_type => :json, :accept => :json})
    rescue => e
      a = e
    end

    order_items['items'].each do |order_item|
      order_products << {
          "order_item_id": order_item['item_id'],
          "qty": order_item['qty_ordered'],
          "row_total": order_item['row_total'],
          "price": order_item['price']

      }
    end
    invoice_info['subtotal'] = 150
    invoice_info['grand_total'] = 200

    shipment_attr =
        {
            "entity": {
                "order_id": order_id,
                "items": order_products
            }

        }
    invoice_attr = {
        "entity": {
            "order_id": order_id,
            "grand_total": invoice_info['grand_total'],
            "subtotal": invoice_info['subtotal'],
            "items": order_products
        }
    }
    # Створення оплати
    invoice_id = Magento2::Invoice.invoice(invoice_attr, @token_key)

    # Створення доставки
    Magento2::Shipment.shipment(shipment_attr, @token_key)
    attr = {
        "statusHistory": {
            "status": "rem_status_code",
        }
    }
    begin
      RestClient.post "http://maxus.beta.qpard.com/index.php/rest/V1/orders/#{order_id}/comments",
                      attr.to_json, {:Authorization => "Bearer #{@token_key}", :content_type => :json, :accept => :json}
    rescue => e
      a = e
    end
    render root_path
  end

end
