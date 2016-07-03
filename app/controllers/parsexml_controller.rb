class ParsexmlController < ApplicationController
  include Parsers
  def index
    parser_xml()
  end
end
