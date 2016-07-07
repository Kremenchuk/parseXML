class ParsexmlController < ApplicationController
  include CommercemlParser
  include CatalogParser
  include ClassifierParser
  include AddressParser
  include OffersParser
  include AddAddress
  include OrderParser

  def index
    #parser_xml()
    create_xml()
  end
end
