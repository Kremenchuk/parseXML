class ParsexmlController < ApplicationController
  include CommercemlParser
  include CatalogParser
  include ClassifierParser
  include AddressParser
  include OffersParser
  included AddAddress

  def index
    #parser_xml()
    create_xml()
  end
end
