Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'parsexml#index'

  get '/parsexml/show'
  get '1c_exchange.php' => 'parsexml#exchange_1c'
  get '/bitrix/admin/1c_exchange.php' => 'parsexml#exchange_1c'
  get '1c_exchange' => 'parsexml#exchange_1c'
  post '1c_exchange' => 'parsexml#exchange_1c'

  get 'add_product' => 'product#add_product_to_magento2'
  get 'update_product' => 'product#update_product_to_magento2'
  get 'get_product' => 'product#get_product_to_magento2'
  get 'create_cart' => 'cart#crate_cart'


  get 'site_to_erp' => 'create_csv#csv_site_to_erp'
  get 'erp_to_site' => 'create_csv#csv_erp_to_site'
  get 'parse_my_doc' => 'parsexml#parse_my_doc'
end
