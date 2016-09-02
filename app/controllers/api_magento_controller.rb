class ApiMagentoController < ApplicationController
  include WriteLogFile


  before_action :autorization, only: :ask_from_1c

  def ask_from_1c
    add_product_to_magento2
  end


  private
    def autorization
      #отримання token
      @token_key = RestClient.post "http://maxus.beta.qpard.com/index.php/rest/V1/integration/admin/token", {"username":USERNAME_ADMIN_MAGENTO, "password":PASSWORD_ADMIN_MAGENTO}.to_json,
                               {:content_type => :json, :accept => :json}
      @token_key = @token_key.to_s.gsub('"','')
    end


    def add_product_to_magento2


      render plain: "ok"
    end















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
  end

















  def experiment(cart_id)
    # Вибрані методи оплати для корзини
    selected = JSON.parse(RestClient.get "http://maxus.beta.qpard.com/index.php/rest/V1/carts/#{cart_id}/selected-payment-method",
                                         {:Authorization => "Bearer #{@token_key}", :content_type => :json, :accept => :json})

    # 'code' => checkmo
    payment = JSON.parse(RestClient.get "http://maxus.beta.qpard.com/index.php/rest/V1/carts/#{cart_id}/payment-methods",
                                        {:Authorization => "Bearer #{@token_key}", :content_type => :json, :accept => :json})
    address_c = JSON.parse(RestClient.get "http://maxus.beta.qpard.com/index.php/rest/V1/customers/1",
                                          {:Authorization => "Bearer #{@token_key}", :content_type => :json, :accept => :json})

    billing_address = JSON.parse(RestClient.get "http://maxus.beta.qpard.com/index.php/rest/V1/carts/#{cart_id}/billing-address",
                                                {:Authorization => "Bearer #{@token_key}", :content_type => :json, :accept => :json})



    begin
      shipping = JSON.parse(RestClient.get "http://maxus.beta.qpard.com/index.php/rest/V1/carts/#{cart_id}/shipping-methods",
                                           {:Authorization => "Bearer #{@token_key}", :content_type => :json, :accept => :json})
    rescue => e
      a = e
    end


    a=2
  end












  def update_attr
    all_attr = JSON.parse(RestClient.get "http://maxus.beta.qpard.com/index.php/rest/V1/products/attributes/?searchCriteria=''",
                                        {:Authorization => "Bearer #{@token_key.to_s.gsub('"','')}", :content_type => :json, :accept => :json})
    attr = {
        "attribute": {
            "attribute_id": 250,
            "attribute_code": "fd_dimming",
            "default_frontend_label": "Димминг 321"
        }
    }
    begin
      result = JSON.parse(RestClient.put "http://maxus.beta.qpard.com/index.php/rest/V1/products/attributes/235",
                                         attr.to_json, {:Authorization => "Bearer #{@token_key.to_s.gsub('"','')}", :content_type => :json, :accept => :json})
    rescue RestClient::ExceptionWithResponse => e
      a = e
    end
    a=2
  end




  def update_cat
    all_cat = JSON.parse(RestClient.get "http://maxus.beta.qpard.com/index.php/rest/all/V1/categories/",
                                        {:Authorization => "Bearer #{@token_key.to_s.gsub('"','')}", :content_type => :json, :accept => :json})

    result_cat = JSON.parse(RestClient.get "http://maxus.beta.qpard.com/index.php/rest/V1/categories/115",
                                           {:Authorization => "Bearer #{@token_key.to_s.gsub('"','')}", :content_type => :json, :accept => :json})

    cat = {
        "category": {
            "name": "name all",
        }
    }
    begin
      RestClient.put "http://maxus.beta.qpard.com/index.php/rest/all/V1/categories/115",
                     cat.to_json, {:Authorization => "Bearer #{@token_key.to_s.gsub('"','')}", :content_type => :json, :accept => :json}
    rescue RestClient::ExceptionWithResponse => e
      render plain: e
    end
    a=2
    render plain: "ok"
  end



  def find_group(group, result, product)
    category = []
    i = 0
    go = true

    category[i] = group.name
    parent_group = Group.find(group.groupable_id)
    while go do
      i +=1
      if parent_group.groupable_type == "Classifier"
        go = false
      else
        parent_group = Group.find(parent_group.groupable_id)
        category[i] = parent_group.name
      end
    end
    category.reverse!
    group_id = compare_category(result, category, 0, (category.count-1), product)

    return group_id
  end


  def compare_category(result, category, i, n, product)
    group_id = -1

    if result
      if result['name'] == ROOT_CATEGORY_MAGENTO
        group_id = result['id']
        group_id_result = compare_category(result['children_data'][0], category, 0, n, product)
        if group_id_result != -1
          group_id = group_id_result
        end

      else

        while i < n do
          if category[i] == result['name']
            if (i+1) == result['level']
              group_id = result['id']
            end
          end
          i += 1
          group_id_result = compare_category(result['children_data'][0], category, i, (n-1), product)
          if group_id_result == -1
            puts_log_file("log_add_product_to_magento2", "WARNING: Не знайдено групу!",
                          "Групу '#{category[i]}' для товару '#{product.name}' ID: '#{product.id_xml}' не знайдено у magento")
          else
            group_id = group_id_result
          end
        end
      end
    end
    return group_id
  end


  def find_attribute_set(result_attribute_set, product)
    # attribute_set_id = -1
    attribute_set = {}
    i = 0
    requisite = Requisite.find_by(name: "ВидНоменклатуры")
    if requisite
      attr_set_1c = ProductRequisite.find_by(product_id: product.id, requisite_id: requisite.id)
      while i < result_attribute_set['total_count'] do
        if result_attribute_set['items'][i]['attribute_set_name'] == attr_set_1c.value
          attribute_set = {:id => result_attribute_set['items'][i]['attribute_set_id'],
                         :name => result_attribute_set['items'][i]['attribute_set_name']}
          i = result_attribute_set['total_count']
        end
        i +=1
      end
    end
    return attribute_set
  end

  def find_attribute(result_attribute, product)
    attribute_value = []
    @not_find_in_constant = {:property_name => nil}
    @not_find_in_magento = {:attr_name => nil}
    product.properties.each do |property|

      @not_find_in_constant[:property_name] = property.name

      ATTRIBUTE_1C_MAGENTO.count.times do |j|
        if ATTRIBUTE_1C_MAGENTO[j][:in_1c].include?(property.name)
          @not_find_in_constant[:property_name] = nil
          @not_find_in_magento[:attr_name] = ATTRIBUTE_1C_MAGENTO[j][:in_1c]

          result_attribute.count.times do |i|
            if ATTRIBUTE_1C_MAGENTO[j][:in_magento].include?(result_attribute[i]['attribute_code'])
              @not_find_in_magento[:attr_name] = nil
              product_propertie = ProductProperty.find_by(product_id: product.id, property_id: property.id)
              handbook = Handbook.find_by(id_xml: product_propertie.value)
              if handbook
                attribute_value << {
                    :attr_id => result_attribute[i]['attribute_id'],
                    :attr_name => result_attribute[i]['attribute_code'],
                    :attr_value => handbook.value}
              end
              break
            else

            end
          end
          break
        end
      end
      if @not_find_in_constant[:property_name]
        puts_log_file("log_add_product_to_magento2", "WARNING: Не знайдено опис атрибуту!",
                      "Арибут '#{@not_find_in_constant[:property_name]}'  не знайдено у описі атрибутів ATTRIBUTE_1C_MAGENTO")
        @not_find_in_constant[:property_name] = nil
      elsif @not_find_in_magento[:attr_name]
        puts_log_file("log_add_product_to_magento2", "WARNING: Не знайдено атрибут!",
                      "Арибут 1C '#{@not_find_in_magento[:attr_name]}' не знайдено у списку атрибутів magento. Для товару '#{product.name}' ID: '#{product.id_xml}'")
        @not_find_in_magento[:attr_name] = nil
      end
    end
    return attribute_value
  end

end


