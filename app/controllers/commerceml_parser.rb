module CommercemlParser

  def parser_xml
    file_xml = './data/from_ERP/import.xml'
    file_offers = './data/from_ERP/offers.xml'

    #file_xml = 'import.xml'
    #парсинг файла import.xml
      xml_doc = Nokogiri::XML(File.open(file_xml))

      if xml_doc.css('Классификатор')
        parse_classifier(xml_doc.css('Классификатор'))
      end

      if xml_doc.css('Каталог')
        parse_catalog(xml_doc.css('Каталог'))
      end

    #парсинг файла offers.xml
      offers_doc = Nokogiri::XML(File.open(file_offers))

      if offers_doc.css('ПакетПредложений')
        parse_offer(offers_doc)
      end





  end

end