class ParsexmlController < ApplicationController
  #require 'nokogiri'
  def index
    parser()
  end


  def parser
    file = './importfile/import.xml'
    xml_doc = Nokogiri::XML(File.open(file))
    classifier_parse(xml_doc)
  end

  def classifier_parse(xml_doc)
    #@parse = xml_doc.at_css('Классификатор')
    Nokogiri::XML::SAX::Parser.new(Parser.new).parse(File.open('./importfile/import.xml'))
  end



end
