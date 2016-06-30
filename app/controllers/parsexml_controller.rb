class ParsexmlController < ApplicationController
  require 'nokogiri'
  def index
    f = File.open('import.xml')
    @doc = Nokogiri::XML(f)
    f.close
    render text: @doc
  end
end
