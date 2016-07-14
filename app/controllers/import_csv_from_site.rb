module ImportCsvFromSite
  def import_products(file)
    CSV.foreach(file, :headers => true) do |row|
      Magento2CatalogProduct.create!(row.to_hash)
    end
  end


  def import_orders(file)
    CSV.foreach(file, :headers => true) do |row|
      Magento2Order.create!(row.to_hash)
    end
  end


  def import_customers(file)
    CSV.foreach(file, :headers => true) do |row|
      Magento2Customer.create!(row.to_hash)
    end
  end

end