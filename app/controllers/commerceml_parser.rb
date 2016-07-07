module CommercemlParser
  def parser_xml
    file_xml = './data/from_ERP/import.xml'
    file_offers = './data/from_ERP/offers.xml'
    file_order_from_ERP = './data/from_ERP/order.xml'


    #file_xml = 'import.xml'
    #парсинг файла import.xml
      xml_doc = Nokogiri::XML(File.open(file_xml))

      @new_commerce_information               = CommerceInformation.new
      @new_commerce_information.version       = xml_doc.css('КоммерческаяИнформация')[0]['ВерсияСхемы']
      @new_commerce_information.date          = xml_doc.css('КоммерческаяИнформация')[0]['ДатаФормирования']
      @new_commerce_information.name_document = "from_ERP_import"
      @new_commerce_information.save!


      if xml_doc.css('Классификатор')
        parse_classifier(xml_doc.css('Классификатор'), @new_commerce_information)
      end

      if xml_doc.css('Каталог')
        parse_catalog(xml_doc.css('Каталог'), @new_commerce_information)
      end



    #парсинг файла offers.xml
      offers_doc = Nokogiri::XML(File.open(file_offers))

      @new_commerce_information               = CommerceInformation.new
      @new_commerce_information.version       = offers_doc.css('КоммерческаяИнформация')[0]['ВерсияСхемы']
      @new_commerce_information.date          = offers_doc.css('КоммерческаяИнформация')[0]['ДатаФормирования']
      @new_commerce_information.name_document = "from_ERP_offers"
      @new_commerce_information.save!

      if offers_doc.css('ПакетПредложений')
        parse_offer(offers_doc, @new_commerce_information)
      end



    #парсинг файла заказов из ERP системы    .xml
      order_doc = Nokogiri::XML(File.open(file_order_from_ERP))

      @new_commerce_information               = CommerceInformation.new
      @new_commerce_information.version       = order_doc.css('КоммерческаяИнформация')[0]['ВерсияСхемы']
      @new_commerce_information.date          = order_doc.css('КоммерческаяИнформация')[0]['ДатаФормирования']
      @new_commerce_information.name_document = "from_ERP_order"
      @new_commerce_information.save!

      if order_doc.css('Документ')
        order_doc.css('Документ').each do |order|
          parse_order(order, @new_commerce_information)
        end
      end


  end









  def create_xml
    new_file = './data/to_ERP/to.xml'
    doc = File.new(new_file, "w")

    @commerce_infor = CommerceMLConvert.last
    @doc = Nokogiri::XML('to.xml')

    @commerce_infor.documents.each do |document|

      node_commerce_inf = Nokogiri::XML::Node.new('КоммерческаяИнформация', @doc)
      node_commerce_inf['ВерсияСхемы'] = "#{@commerce_infor.version}"
      node_commerce_inf['ДатаФормирования'] = "#{@commerce_infor.date}"
      @doc.root = node_commerce_inf
      node_document = Nokogiri::XML::Node.new('Документ', @doc)
      node_commerce_inf.add_child node_document

      node_id = Nokogiri::XML::Node.new('Ид', @doc)
      node_id.content = "#{document.id_xml}"
      node_document.add_child node_id

      node_number = Nokogiri::XML::Node.new('Номер', @doc)
      node_number.content = "#{document.number}"
      node_document.add_child node_number

      node_date = Nokogiri::XML::Node.new('Дата', @doc)
      node_date.content = "#{document.date}"
      node_document.add_child node_date

      node_economic_op = Nokogiri::XML::Node.new('ХозОперация', @doc)
      node_economic_op.content = document.economic_op
      node_document.add_child node_economic_op

      node_role = Nokogiri::XML::Node.new('Роль', @doc)
      node_role.content = "#{document.role}"
      node_document.add_child node_role

      node_currency = Nokogiri::XML::Node.new('Валюта', @doc)
      node_currency.content = "#{document.currency}"
      node_document.add_child node_currency

      node_course = Nokogiri::XML::Node.new('Курс', @doc)
      node_course.content = "#{document.course}"
      node_document.add_child node_course

      node_sum = Nokogiri::XML::Node.new('Сумма', @doc)
      node_sum.content = "#{document.sum}"
      node_document.add_child node_sum

      node_contractors = Nokogiri::XML::Node.new('Контрагенты', @doc)
      node_document.add_child node_contractors

      add_contractors(document.contractors, node_contractors)

      node_time = Nokogiri::XML::Node.new('Время', @doc)
      node_time.content = "#{document.time}"
      node_document.add_child node_time

    end

    File.write(doc, @doc.to_xml)
  end


  #добавляем контрагентова для документа

  def add_contractors(contractors, master_node)
    contractors.each do |contractor|
      node_contractor = Nokogiri::XML::Node.new('Контрагент', @doc)
      master_node.add_child node_contractor

      node_id = Nokogiri::XML::Node.new('Ид', @doc)
      node_id.content = "#{contractor.id_xml}"
      node_contractor.add_child node_id

      node_name = Nokogiri::XML::Node.new('Ид', @doc)
      node_name.content = "#{contractor.name}"
      node_contractor.add_child node_name

      node_role = Nokogiri::XML::Node.new('Роль', @doc)
      node_role.content = "#{contractor.role}"
      node_contractor.add_child node_role

      if contractor.personable_type == "LegalEntity"
        add_legal_entity(contractor.personable_id, master_node)
      else
        add_physical_persone(contractor.personable_id, master_node)
      end
    end
  end


  #добавляем реквизити юр. лица если покупатель юр. лицо

  def add_legal_entity(legal_entity, master_node)
    node_official_name = Nokogiri::XML::Node.new('ОфициальноеНаименование', @doc)
    node_official_name.content = "#{legal_entity.official_name}"
    master_node.add_child node_official_name

    if legal_entity.inn
      node_inn = Nokogiri::XML::Node.new('ИНН', @doc)
      node_inn.content = "#{legal_entity.inn}"
      master_node.add_child node_inn
    end

    if legal_entity.kpp
      node_kpp = Nokogiri::XML::Node.new('КПП', @doc)
      node_kpp.content = "#{legal_entity.kpp}"
      master_node.add_child node_kpp
    end

    if legal_entity.egrpo
      node_egrpo = Nokogiri::XML::Node.new('ЕГРПО', @doc)
      node_egrpo.content = "#{legal_entity.egrpo}"
      master_node.add_child node_egrpo
    end

    if legal_entity.okpo
        node_okpo = Nokogiri::XML::Node.new('ОКПО', @doc)
      node_okpo.content = "#{legal_entity.okpo}"
      master_node.add_child node_okpo
    end

    if legal_entity.address
      node_legal_address = Nokogiri::XML::Node.new('ЮридическийАдрес', @doc)
      master_node.add_child node_legal_address

      node_address = Nokogiri::XML::Node.new('Представление', @doc)
      node_address.content = "#{legal_entity.address}"
      node_legal_address.add_child node_address

      add_address_fields(legal_entity, node_legal_address, @doc)
    end

  end







  # def to_my_xml(options = {})
  #   require 'builder'
  #   options[:indent] ||= 2
  #   xml = options[:builder] ||= ::Builder::XmlMarkup.new(indent: options[:indent])
  #   xml.instruct! :xml, :version=>"1.0", :encoding => "ISO-8859-1"
  #   xml.level_one do
  #     xml.tag!(:second_level, 'content')
  #   end
  # end

end