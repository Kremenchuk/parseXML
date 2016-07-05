module CommercemlParser

  def parser_xml
    file1 = './importfile/import.xml'
    #file1 = 'import.xml'
    xml_doc = Nokogiri::XML(File.open(file1))

    # if xml_doc.css('Классификатор')
    #   parse_classifier(xml_doc.css('Классификатор'))
    # end

    if xml_doc.css('Каталог')
      parse_catalog(xml_doc.css('Каталог'))
    end
  end




end