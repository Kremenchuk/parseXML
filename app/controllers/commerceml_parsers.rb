module CommercemlParsers

  def parser_xml
    file1 = './importfile/import.xml'
    #file1 = 'import.xml'
    xml_doc = Nokogiri::XML(File.open(file1))

    #if xml_doc.css('Классификатор').text != ""
    #  parse_classifier(xml_doc.css('Классификатор'))
    #end
    @new_owner = Owner.new

    @new_catalog = MlCatalog.new
    a=2

    #if xml_doc.css('Каталог').text != ""
    #  parse_catalog(xml_doc.css('Каталог'))
    #end
  end




end