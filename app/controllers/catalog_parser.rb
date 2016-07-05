module CatalogParser

  def parse_catalog(catalog_doc)
    @new_catalog = Catalog.new
    @new_catalog.id_xml = catalog_doc.at_css('Ид').text
    @new_catalog.name = catalog_doc.at_css('Наименование').text
    @new_catalog.only_change = catalog_doc.css('Каталог')[0]['СодержитТолькоИзменения']
    if catalog_doc.at_css('ИдКлассификатора').text != ""
      classifier = Classifier.find_by(id_xml: catalog_doc.at_css('ИдКлассификатора').text)
      classifier.catalogs << @new_catalog
    end
    owner = Owner.find_by(id_xml: catalog_doc.at_css('Владелец Ид').text)
    unless owner
      owner = parse_owner(catalog_doc.at_css('Владелец'))
    end
    owner.catalogs << @new_catalog
    parse_product(catalog_doc.css('Товары'))
  end


  #Парсим товары

  def parse_product(product_doc)
    product_doc.css('Товар').each do |product|
      @new_product = Product.new
      if product.at_css('Ид')
        @new_product.id_xml     = product.at_css('Ид').text
      end
      if product.at_css('Артикул')
        @new_product.vendorcode = product.at_css('Артикул').text
      end
      if product.at_css('Штрихкод')
        @new_product.barcode    = product.at_css('Штрихкод').text
      end
      if product.at_css('Картинка')
        product.css('Картинка').count.times do |i|
          new_image = ProductImage.new
          new_image.link_image = product.css('Картинка')[i].text
          @new_product.product_images << new_image
          new_image.save!
        end
      end
      @new_product.name         = product.at_css('Наименование').text


      #парсим ед. изм
        unit = parse_unit(product.at_css('БазоваяЕдиница'))
        unit.products << @new_product

      if product.css('Группы')
        product.css('Группы Ид').each do |group|
          prod_group = Group.find_by(id_xml: group.text)
          if prod_group
            @new_product.groups << prod_group
          end
        end
      end
      @new_catalog.products << @new_product
=begin
      #парсим свойства товара
        if product.css('ЗначенияСвойств')
          parse_product_property(product.css('ЗначенияСвойств'))
        end
=end

      #парсим СтавкиНалогов товара
      if product.css('СтавкиНалогов')
        parse_taxes(product.css('СтавкиНалогов'))
      end



    end
  end


  #парсим ед.измерения

  def parse_unit(unit_doc)
    @new_unit = Unit.new
    @new_unit.name       = unit_doc.text
    @new_unit.code       = unit_doc['Код']
    @new_unit.full_name  = unit_doc['НаименованиеПолное']
    if unit_doc['МеждународноеСокращение']
      @new_unit.intern_cut = unit_doc['МеждународноеСокращение']
    end
    @new_unit.save!
    return @new_unit
  end


  #парсим свойства товара

  def parse_product_property(property_doc)
    property_doc.css('ЗначенияСвойства').each do |property|
      prod_property = Property.find_by(id_xml: property.css('Ид').text)

      if prod_property
        new_product_property = ProductProperty.new
        new_product_property.product  = @new_product
        new_product_property.property = prod_property
        if property.css('Значение')
          new_product_property.value  = property.css('Значение').text
        end
        new_product_property.save!
      end

      if property.css('Значение')
        property.css('Значение').count.times do |i|
          if property.css('Значение')[i].text != ""
            prod_handbook = Handbook.find_by(id_xml: property.css('Значение')[i].text)
            if prod_handbook
              @new_product.handbooks << prod_handbook
            end
          end
        end
      end
    end
  end


  #парсим СтавкиНалогов

  def parse_taxes(tax_doc)
    tax_doc.css('СтавкаНалога').each do |tax|
      product_tax = Tax.find_by(name: tax.at_css('Наименование').text)
      if product_tax
        insert_new_product_tax_value(tax.at_css('Ставка').text, product_tax)
      else
        @new_tax      = Tax.new
        @new_tax.name = tax.at_css('Наименование').text
        @new_tax.save!
        insert_new_product_tax_value(tax.at_css('Ставка').text, @new_tax)
      end
    end
  end

  def insert_new_product_tax_value(value, product_tax)
    @new_product_tax_value         = ProductTaxValue.new
    @new_product_tax_value.product = @new_product
    @new_product_tax_value.tax     = product_tax
    @new_product_tax_value.value   = value
    @new_product_tax_value.save!
  end


end

