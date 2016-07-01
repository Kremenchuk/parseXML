class Parser < Nokogiri::XML::SAX::Document

  def start_element(name, attrs = [])
    # обрабатываем каждый элемент (получаем имя и атрибуты)
    if @parse == nil
      @parse = name
    else
      @parse +="/" + name
    end
    a=2
  end
  def characters(data)
    @data = data
    a=3
    # любые символы между началом и концом элемента
  end
  def end_element(name)
    @parse = ''
    # как только достигнут закрывающийся тег элемента (получаем имя элемента)
  end
end