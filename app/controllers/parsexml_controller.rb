class ParsexmlController < ApplicationController
  include CommercemlParser
  include CatalogParser
  include ClassifierParser
  include AddressParser
  include OffersParser

  def index
    parser_xml()
    create_xml()
  end
end
