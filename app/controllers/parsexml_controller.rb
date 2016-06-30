class ParsexmlController < ApplicationController
  require 'nokogiri'
  def index
    f = File.open('import.xml')
    doc = Nokogiri::XML(f)
    f.close
    @parse = doc.at_xpath('//Классификатор//Ид')
    @id_xml = @parse.to_s.sub('<Ид>','').sub('</Ид>','')
    #ParseInfo.create! [id_xml: @id_xml]
  end
end
