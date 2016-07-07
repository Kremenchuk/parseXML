module OrderParser
  def parse_order(order, commerce_information)


    @new_document             = Document.new
    @new_document.id_xml      = order.at_css('Ид').text
    @new_document.number      = order.at_css('Номер').text
    @new_document.date        = order.at_css('Дата').text
    @new_document.economic_op = order.at_css('ХозОперация').text
    @new_document.role        = order.at_css('Роль').text
    @new_document.currency    = order.at_css('Валюта').text
    @new_document.course      = order.at_css('Курс').text
    @new_document.sum         = order.at_css('Сумма').text
    @new_document.time        = order.at_css('Время').text
    @new_document.time        = order.at_css('Комментарий').text

    commerce_information.documents << @new_document

    if order.at_css('Контрагенты')
      parse_contractor(order.at_css('Контрагенты'))
    end

  end


  def parse_contractor(contractors_doc)
    contractors_doc.css('Контрагент').each do |contractor|

    end
  end




end