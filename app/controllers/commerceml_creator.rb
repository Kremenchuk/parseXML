module CommercemlCreator
=begin
  require '/creators/add_address'
  require '/creators/to_erp_order'
=end


  def create_order_to_erp
    file = './data/to_ERP/to.xml'
    doc = File.new(file, "w")
    doc.close
    doc = File.open(file, "a")
    document = create_to_erp_order()
    File.write(doc, document.to_xml(:encoding => "UTF-8"))
    doc.close
    a=2

    # xml = Builder::XmlMarkup.new
    # xml.instruct! :xml, :version=>"1.0", :encoding=>"windows-1251"

    # doc = Nokogiri::XML::Builder(file, :encoding => "UTF-8")
    #
    # doc.to_xml.encoding # => #<Encoding:UTF-8>
    # puts doc.to_xml
    # a=3



    # работает но не меняет реальную кодировку
    # text = File.read(file)
    # replace = text.gsub('<?xml version="1.0"?>', '<?xml version="1.0" encoding="UTF-8"?>')
    # File.open(file, "w") {|file| file.puts replace.to_xml}
  end
end