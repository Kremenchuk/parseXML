class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :id_xml
      t.string :barcode      #штрих код
      t.string :vendorcode   #артикул
      t.string :name
      t.boolean :from_erp
      t.boolean :from_site
      t.boolean :to_erp
      t.boolean :to_site
      t.integer :catalog_id
      t.integer :unit_id
      t.timestamps
    end
  end
end
