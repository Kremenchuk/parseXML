module CommercemlParser

  def parser_xml
    file_xml = './data/from_ERP/import.xml'
    file_offers = './data/from_ERP/offers.xml'

    #file_xml = 'import.xml'
    #парсинг файла import.xml
      xml_doc = Nokogiri::XML(File.open(file_xml))

      @new_commerce_information         = CommerceInformation.new
      @new_commerce_information.version = xml_doc.css('КоммерческаяИнформация')[0]['ВерсияСхемы']
      @new_commerce_information.date    = xml_doc.css('КоммерческаяИнформация')[0]['ДатаФормирования']
      @new_commerce_information.save!


      if xml_doc.css('Классификатор')
        parse_classifier(xml_doc.css('Классификатор'), @new_commerce_information)
      end

      if xml_doc.css('Каталог')
        parse_catalog(xml_doc.css('Каталог'), @new_commerce_information)
      end

    #парсинг файла offers.xml
      offers_doc = Nokogiri::XML(File.open(file_offers))

      @new_commerce_information         = CommerceInformation.new
      @new_commerce_information.version = offers_doc.css('КоммерческаяИнформация')[0]['ВерсияСхемы']
      @new_commerce_information.date    = offers_doc.css('КоммерческаяИнформация')[0]['ДатаФормирования']
      @new_commerce_information.save!

      if offers_doc.css('ПакетПредложений')
        parse_offer(offers_doc, @new_commerce_information)
      end
  end

  def create_xml

  end

end