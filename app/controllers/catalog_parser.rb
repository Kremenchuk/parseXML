module CatalogParser

  def parse_catalog(catalog_doc)
    new_catalog = Catalog.new
    new_catalog.id_xml = catalog_doc.at_css('Ид').text
    new_catalog.name = catalog_doc.at_css('Наименование').text
    new_catalog.only_change = catalog_doc.css('Каталог')[0]['СодержитТолькоИзменения']
    if catalog_doc.at_css('ИдКлассификатора').text != ""
      classifier = Classifier.find_by(id_xml: catalog_doc.at_css('ИдКлассификатора').text)
      classifier.catalogs << new_catalog
    end
    owner = Owner.find_by(id_xml: catalog_doc.at_css('Владелец Ид').text)
    unless owner
      owner = parse_owner(catalog_doc.at_css('Владелец'))
    end
    owner.catalogs << new_catalog
    parse_product(catalog_doc.css('Товары'))
  end


  #Парсим товары

  def parse_product(product_doc)

  end
end

