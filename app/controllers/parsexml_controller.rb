class ParsexmlController < ApplicationController
  include AddAddress
  include AddressParser
  include CatalogParser
  include ClassifierParser
  include CommercemlCreator
  include CommercemlParser
  include OffersParser
  include OrderParser
  include ToErpOrder

  def index
    #parser_product_from_erp
    parse_order_from_erp
    #create_order_to_erp
  end
end
