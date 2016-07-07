module CommercemlCreator
=begin
  require '/creators/add_address'
  require '/creators/to_erp_order'
=end


  def create_order_to_erp
    file = './data/to_ERP/to.xml'
    doc = File.new(file, "w")

    create_to_erp_order(doc)

  end
end