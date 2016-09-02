class ProductController < ApplicationController


  def add_product_to_magento2
    quantity = "0"
    price = "0"
    img = img_to_m2
    attr ={
        "product": {
            "sku": "new_rem_product5",
            "name": "new rem product5",
            "attribute_set_id": 4,
            "price": price,
            "status": 1,
            "visibility": 2,
            "type_id": "simple",
            "extension_attributes": {
                "stock_item": {
                    "qty": quantity
                }},
            "custom_attributes": [
                {
                    "attribute_code": "rem_ms",
                    "value": ["962", "961"]
                },
                {
                    "attribute_code": "url_key",
                    "value": "rem-product"
                }
            ],
            "media_gallery_entries": img
            # "saveOptions": true
        }
    }


    # catalogProductRepositoryV1
    begin
      product = RestClient.post "http://maxus.beta.qpard.com/index.php/rest/V1/products",
                                           attr.to_json, {:Authorization => "Bearer #{@token_key}", :content_type => :json, :accept => :json}
    rescue => e
      a = e
    end
    redirect_to root_path
  end




  def update_product_to_magento2
    # result = []
    begin
      images = JSON.parse(RestClient.get "http://maxus.beta.qpard.com/index.php/rest/all/V1/products/new_rem_product5/media",
                                         {:Authorization => "Bearer #{@token_key}", :content_type => :json, :accept => :json})
    rescue => e
      a = e
    end
    images.each do |image|
      begin
        RestClient.delete "http://maxus.beta.qpard.com/index.php/rest/V1/products/all/new_rem_product5/media/#{image['id']}",
                          {:Authorization => "Bearer #{@token_key}", :content_type => :json, :accept => :json}
      rescue => e
        a = e
      end
    #   if image['types'] == []
    #   result << {
    #
    #           'id'          => image['id'],
    #           'media_type'  => 'image',
    #           'types'       => [],
    #           # 'file'        => image['file'],
    #           'content'     => {
    #               'type' => 'image/jpeg'
    #
    #       }
    #   }
    #   else
    #     result << {
    #
    #         'id'          => image['id'],
    #         'media_type'  => 'image',
    #         'types'       => ['image', 'small_image', 'thumbnail', 'swatch_image'],
    #         # 'file'        => image['file'],
    #         'content'     => {
    #             'type' => 'image/gif',
    #             'name' => File.basename(Rails.root.join('public', 'uploads', 'Screenshot.gif')),
    #             'base64_encoded_data' => Base64.encode64(File.open(Rails.root.join('public', 'uploads', 'Screenshot.gif'), 'r').read)
    #         }
    #     }
    #   end
    #
    # end


    end

    # update_image
    result = img_to_m2
    attr ={
        "product": {
            "id": 2896,
            "sku": "new_rem_product5",
            "visibility": 2,
            "extension_attributes": {
                "stock_item": {
                    "qty": 100 #14393
                }},
            'custom_attributes': [
                # {
                #     "attribute_code": "is_anchor",
                #     "value": "1"
                # },
                # {
                #     'attribute_code': "url_key",
                #     'value': 'rem-product11111'
                # }
            ]
            # "media_gallery_entries": result
            # "saveOptions": true
        }
    }
        # catalogProductRepositoryV1
    begin
      product = RestClient.put "http://maxus.beta.qpard.com/index.php/rest/all/V1/products/new_rem_product5",
                                attr.to_json, {:Authorization => "Bearer #{@token_key}", :content_type => :json, :accept => :json}
    rescue => e
      a = e
    end
    # insert_image
    redirect_to root_path
  end



  def get_product_to_magento2
    # catalogProductRepositoryV1
    begin
      product = JSON.parse(RestClient.get "http://maxus.beta.qpard.com/index.php/rest/V1/products/#{params[:sku]}",
                                           {:Authorization => "Bearer #{@token_key}", :content_type => :json, :accept => :json})
    rescue => e
      a = e
    end
    redirect_to root_path
  end


  def img_to_m2
    file = Dir[File.join(Rails.root.join('public', 'uploads'), '*')]
    result = []
    file.each_with_index do |product_image, index|
      result <<
          {
              'position'    => index,
              'media_type'  => 'image',
              'disabled'    => false,
              'label'       => File.basename(product_image),
              # 'types'       => index == 0 ? ['image', 'small_image', 'thumbnail', 'swatch_image'] : [],
              'content'     => {
                  'type' => 'image/jpeg',
                  'name' => File.basename(product_image),
                  'base64_encoded_data' => Base64.encode64(File.open(product_image, 'r').read)
              }
          }
    end
    return result
  end


  # def insert_image
  #   file = Dir[File.join(Rails.root.join('public', 'uploads'), '*')]
  #   file.each_with_index do |product_image, index|
  #     attr =     {
  #         "entry": {
  #             'position'    => index,
  #             'media_type'  => 'image',
  #             'disabled'    => false,
  #             'label'       => File.basename(product_image),
  #             'types'       => index == 0 ? ['image', 'small_image', 'thumbnail', 'swatch_image'] : [],
  #             'content'     => {
  #                 'type' => 'image/jpeg',
  #                 'name' => File.basename(product_image),
  #                 'base64_encoded_data' => Base64.encode64(File.open(product_image, 'r').read)
  #             }
  #         }
  #     }
  #     begin
  #       RestClient.post "http://maxus.beta.qpard.com/index.php/rest/V1/products/new_rem_product1/media",
  #                     attr.to_json, {:Authorization => "Bearer #{@token_key}", :content_type => :json, :accept => :json}
  #     rescue => e
  #       a = e
  #     end
  #   end
  # end
  #
  #
  #
  #   def update_image
  #     # result = []
  #     result =''
  #     begin
  #       images = JSON.parse(RestClient.get "http://maxus.beta.qpard.com/index.php/rest/V1/products/new_rem_product1/media",
  #                                           {:Authorization => "Bearer #{@token_key}", :content_type => :json, :accept => :json})
  #     rescue => e
  #       a = e
  #     end
  #       images.each do |image|
  #         begin
  #           # result = {
  #           #     "entry": {
  #           #
  #           #         'id'          => image['id'],
  #           #         'media_type'  => 'image',
  #           #         'types'       => [],
  #           #         'file'        => image['file'],
  #           #         'content'     => {
  #           #                           'type' => 'image/gif',
  #           #                           'name' => File.basename(Rails.root.join('public', 'uploads', 'Screenshot.gif')),
  #           #                           'base64_encoded_data' => Base64.encode64(File.open(Rails.root.join('public', 'uploads', 'Screenshot.gif'), 'r').read)
  #           #                       }
  #           #     }
  #           # }
  #           if image['types'] == []
  #               result = {"entry": {
  #
  #                       'id'          => image['id'],
  #                       'media_type'  => 'image',
  #                       'types'       => ['image', 'small_image', 'thumbnail', 'swatch_image'],
  #                       # 'file'        => image['file'],
  #                       'content'     => {
  #                           'type' => 'image/jpeg'
  #
  #                   }
  #                }
  #               }
  #               else
  #                 result = {"entry": {
  #
  #                     'id'          => image['id'],
  #                     'media_type'  => 'image',
  #                     'types'       => [],
  #                     'file'        => image['file'],
  #                     'content'     => {
  #                         'type' => 'image/gif',
  #                         'name' => File.basename(Rails.root.join('public', 'uploads', 'Screenshot.gif')),
  #                         'base64_encoded_data' => Base64.encode64(File.open(Rails.root.join('public', 'uploads', 'Screenshot.gif'), 'r').read)
  #                     }
  #                 }
  #                 }
  #               end
  #
  #
  #           RestClient.put "http://maxus.beta.qpard.com/index.php/rest/V1/products/new_rem_product1/media/#{image['id']}",
  #                          result.to_json,{:Authorization => "Bearer #{@token_key}", :content_type => :json, :accept => :json}
  #         rescue => e
  #           a=e
  #         end
  #       end
  #
  #       return result
  #
  #       #   begin
  #       #     RestClient.delete "http://maxus.beta.qpard.com/index.php/rest/V1/products/new_rem_product1/media/#{image['id']}",
  #       #                     {:Authorization => "Bearer #{@token_key}", :content_type => :json, :accept => :json}
  #       #   rescue => e
  #       #     a = e
  #       #   end
  #       # end
  #       #
  #       # insert_image
  #     end

end


