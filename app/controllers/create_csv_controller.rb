class CreateCsvController < ApplicationController
  include ImportCsvFromSite


  def site_to_erp
    file_products = './data/from_site/catalog_product.csv'
    file_orders = './data/from_site/orders.csv'
    file_customers = './data/from_site/customers.csv'
    import_products(file_products)
    import_orders(file_orders)
    import_customers(file_customers)
    render text: "all ok"
  end

end
