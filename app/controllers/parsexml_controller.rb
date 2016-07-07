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



=begin
  require '/commerceml/commerceml_creator'
  require '/commerceml/commerceml_parser'
=end

  def index
    #parser_product_from_erp
    parse_order_from_erp
    create_order_to_erp
  end
end
