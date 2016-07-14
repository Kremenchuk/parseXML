Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'parsexml#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



  get '/parsexml/show'
  get '1c_exchange.php' => 'parsexml#exchange_1c'
  get '/bitrix/admin/1c_exchange.php' => 'parsexml#exchange_1c'
  get '1c_exchange' => 'parsexml#exchange_1c'
  post '1c_exchange' => 'parsexml#exchange_1c'

  get 'site_to_erp' => 'create_csv#site_to_erp'
end
