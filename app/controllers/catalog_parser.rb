module CatalogParser

  def parse_catalog(catalog_doc)
    catalog_doc.each do |catalog|
      @new_catalog = MlCatalog.new
      @new_catalog.id_xml = catalog.css('Ид').text
      @new_catalog.name = catalog.css('Наименование').text
      @new_catalog.changes = xml_doc.css('Каталог')[0]['СодержитТолькоИзменения']
      if catalog.css('ИдКлассификатора').text != ""
        classifier = Classifier.find_by(id_xml: catalog.css('ИдКлассификатора').text)
        classifier.catalogs << @new_catalog
      end
      owner = Owner.find_by(id_xml: catalog.css('Владелец Ид').text)
      unless owner
        owner = parse_owner(catalog.css('Владелец'))
      end
      owner.catalogs << @new_catalog
    end
  end

end