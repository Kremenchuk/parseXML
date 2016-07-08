module ToErpOrder


  def create_to_erp_order(doc)

    @commerce_infor = CommerceInformation.find_by(name_document: "from_ERP_order")
    @doc = Nokogiri::XML('to.xml')

    node_commerce_inf = Nokogiri::XML::Node.new('КоммерческаяИнформация', @doc)
    node_commerce_inf['ВерсияСхемы'] = "#{@commerce_infor.version}"
    node_commerce_inf['ДатаФормирования'] = "#{@commerce_infor.date}"
    @doc.root = node_commerce_inf

    @commerce_infor.documents.each do |document|

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
      a=22

      File.write(doc, @doc.to_xml)
    end

    doc.close
  end



  #добавляем контрагентова для документа

  def add_contractors(contractors, master_node)
    contractors.each do |contractor|
      node_contractor = Nokogiri::XML::Node.new('Контрагент', @doc)
      master_node.add_child node_contractor

      node_id = Nokogiri::XML::Node.new('Ид', @doc)
      node_id.content = "#{contractor.id_xml}"
      node_contractor.add_child node_id

      node_name = Nokogiri::XML::Node.new('Наименование', @doc)
      node_name.content = "#{contractor.name}"
      node_contractor.add_child node_name

      node_role = Nokogiri::XML::Node.new('Роль', @doc)
      node_role.content = "#{contractor.role}"
      node_contractor.add_child node_role

      if contractor.personable_type == "LegalEntity"
        add_legal_entity(contractor.personable_id, node_contractor)
      else
        add_physical_persone(contractor.personable_id, node_contractor)
      end
    end
  end


  #добавляем реквизити юр. лица если покупатель юр. лицо

  def add_legal_entity(legal_entity, master_node)
    legal_entity = LegalEntity.find(legal_entity)

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


    #добавляем физических лиц

  def add_physical_persone(physical_persone, master_node)
    physical_persone = PhysicalPersone.find(physical_persone)

    node_full_name = Nokogiri::XML::Node.new('ПолноеНаименование', @doc)
    node_full_name.content = "#{physical_persone.full_name}"
    master_node.add_child node_full_name

    if physical_persone.appeal
      node_appeal = Nokogiri::XML::Node.new('Обращение', @doc)
      node_appeal.content = "#{physical_persone.appeal}"
      master_node.add_child node_appeal
    end

    if physical_persone.last_name
      node_last_name = Nokogiri::XML::Node.new('Фамилия', @doc)
      node_last_name.content = "#{physical_persone.last_name}"
      master_node.add_child node_last_name
    end

    if physical_persone.first_name
      node_first_name = Nokogiri::XML::Node.new('Имя', @doc)
      node_first_name.content = "#{physical_persone.first_name}"
      master_node.add_child node_first_name
    end

    if physical_persone.patronymic
      node_patronymic = Nokogiri::XML::Node.new('Отчество', @doc)
      node_patronymic.content = "#{physical_persone.patronymic}"
      master_node.add_child node_patronymic
    end

    if physical_persone.date_birth
      node_date_birth = Nokogiri::XML::Node.new('ДатаРождения', @doc)
      node_date_birth.content = "#{physical_persone.date_birth}"
      master_node.add_child node_date_birth
    end

    if physical_persone.inn
      node_inn = Nokogiri::XML::Node.new('ИНН', @doc)
      node_inn.content = "#{physical_persone.inn}"
      master_node.add_child node_inn
    end

    if physical_persone.kpp
      node_kpp = Nokogiri::XML::Node.new('ДатаРождения', @doc)
      node_kpp.content = "#{physical_persone.kpp}"
      master_node.add_child node_kpp
    end

    if physical_persone.identity_card_id
      node_identity_card = Nokogiri::XML::Node.new('УдостоверениеЛичности', @doc)
      master_node.add_child node_identity_card

      add_identity_card(physical_persone, node_identity_card)
    end


    if physical_persone.address
      node_physical_address = Nokogiri::XML::Node.new('АдресРегистрации', @doc)
      master_node.add_child node_physical_address

      node_address = Nokogiri::XML::Node.new('Представление', @doc)
      node_address.content = "#{physical_persone.address}"
      node_physical_address.add_child node_address

      add_address_fields(physical_persone, node_physical_address, @doc)
    end
  end


  #Идентификационная карта

  def add_identity_card(physical_persone, master_node)
    if physical_persone.identity_card.type_document
      node_type_document = Nokogiri::XML::Node.new('ВидДокумента', @doc)
      node_type_document.content = "#{physical_persone.identity_card.type_document}"
      master_node.add_child node_type_document
    end

    if physical_persone.identity_card.series
      node_series = Nokogiri::XML::Node.new('Серия', @doc)
      node_series.content = "#{physical_persone.identity_card.series}"
      master_node.add_child node_series
    end

    if physical_persone.identity_card.number
      node_number = Nokogiri::XML::Node.new('Номер', @doc)
      node_number.content = "#{physical_persone.identity_card.number}"
      master_node.add_child node_number
    end

    if physical_persone.identity_card.issue_date
      node_issue_date = Nokogiri::XML::Node.new('ДатаВыдачи', @doc)
      node_issue_date.content = "#{physical_persone.identity_card.issue_date}"
      master_node.add_child node_issue_date
    end

    if physical_persone.identity_card.issued_by
      node_issued_by = Nokogiri::XML::Node.new('КемВыдан', @doc)
      node_issued_by.content = "#{physical_persone.identity_card.issued_by}"
      master_node.add_child node_issued_by
    end
  end



   # def to_my_xml(options = {})
   #   require 'builder'
   #   options[:indent] ||= 2
   #   xml = options[:builder] ||= ::Builder::XmlMarkup.new(indent: options[:indent])
   #   xml.instruct! :xml, :version=>"1.0", :encoding => "UTF-8"
   #   xml.level_one do
   #     xml.tag!(:second_level, 'content')
   #   end
   # end

end