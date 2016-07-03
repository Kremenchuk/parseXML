module Parsers
  def parser_xml
    file1 = './importfile/import.xml'
    #file1 = 'import.xml'
    xml_doc = Nokogiri::XML(File.open(file1))
    if xml_doc.css('Классификатор')
      parse_classifier(xml_doc.css('Классификатор'))
    end

  end


  #разбираем Классификатор

  def parse_classifier(classifier_doc)
    @new_classifier = Classifier.new
    @new_classifier.id_xml = classifier_doc.at_css('Ид').text
    @new_classifier.name   = classifier_doc.at_css('Наименование').text
    if classifier_doc.css('Владелец').text != ""
      parse_owner(classifier_doc.css('Владелец'))
    end
    @new_classifier.owner = @new_ownner
    @new_classifier.save!
  end


  #разбираем владельца

  def parse_owner(owner_doc)
    @new_ownner = Owner.new
    @new_ownner.id_xml = owner_doc.at_css('Ид').text
    @new_ownner.name = owner_doc.at_css('Наименование').text
    @new_ownner.official_name = owner_doc.at_css('ОфициальноеНаименование').text
    @new_ownner.address = owner_doc.at_css('ЮридическийАдрес Представление').text
    if owner_doc.css('ЮридическийАдрес АдресноеПоле').text != ""
      parse_address(@new_ownner, owner_doc.css('ЮридическийАдрес АдресноеПоле'))
    end
    @new_ownner.inn = owner_doc.at_css('ИНН').text
    if owner_doc.at_css('КПП')
      @new_ownner.kpp = owner_doc.at_css('КПП').text
    end
    if owner_doc.at_css('ОКПО')
      @new_ownner.okpo = owner_doc.at_css('ОКПО').text
    end

    @new_ownner.save!

    if owner_doc.css('РасчетныеСчета').text != ""
      parse_payment_account(owner_doc.css('РасчетныеСчета'))
    end

  end


  #разбираем расчетные счета

  def parse_payment_account(payment_accounts)
    @new_payment_account = PaymentAccount.new
    @new_payment_account.owner = @new_ownner
    payment_accounts.each do |payment_account|
      @new_payment_account.payment_account = payment_account.css('НомерСчета').text
      @new_payment_account.save!
      if payment_account.css('Банк').text != ""
        parse_bank(payment_account.css('Банк'), false)
      end
      if payment_account.css('БанкКорреспондент').text != ""
        parse_bank(payment_account.css('БанкКорреспондент'), true)
      end
    end
  end


  #разбираем банки

  def parse_bank(bank,corespondent_bank)
    @new_bank = Bank.new
    @new_bank.payment_account = @new_payment_account
    @new_bank.corespondent_bank = corespondent_bank
    @new_bank.name = bank.css('Наименование').text
    @new_bank.correspondent_account = bank.css('СчетКорреспондентский').text
    @new_bank.address = bank.css('Представление').text
    if bank.css('Адрес АдресноеПоле').text != ""
      parse_address(@new_bank, bank.css('Адрес АдресноеПоле'))
    end
    @new_bank.bik = bank.css('БИК').text
    @new_bank.save!
  end


  #парсим адрес если встречаем 'АдресноеПоле'

  def parse_address(object, address_fields)
    address_fields.each do |address_field|
      case address_field.css('Тип').text
        when 'Почтовый индекс'
          object.post_index = address_field.css('Значение').text
        when 'Страна'
          object.country = address_field.css('Значение').text
        when 'Регион'
          object.region = address_field.css('Значение').text
        when 'Район'
          object.area = address_field.css('Значение').text
        when 'Населенный пункт'
          object.city = address_field.css('Значение').text
        when 'Город'
          object.city = address_field.css('Значение').text
        when 'Улица'
          object.street = address_field.css('Значение').text
        when 'Дом'
          object.build = address_field.css('Значение').text
        when 'Корпус'
          object.housing = address_field.css('Значение').text
        when 'Квартира'
          object.flat = address_field.css('Значение').text
      end
    end
  end


end