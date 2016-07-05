class CreatePriceTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :price_types do |t|
      t.string :id_xml
      t.string :name
      t.string :currency
      t.string :into_amount
      t.integer :tax_id
      t.timestamps
    end
  end
end
