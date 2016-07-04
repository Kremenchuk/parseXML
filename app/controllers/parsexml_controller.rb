class ParsexmlController < ApplicationController
  include CommercemlParser
  include CatalogParser
  include ClassifierParser
  include AddressParser


  def index
    parser_xml()
  end
end
