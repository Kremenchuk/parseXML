class CreateDocumentsProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :documents_products do |t|
      t.integer :document_id
      t.integer :product_id
      t.string :quantity
      t.string :sum
      t.timestamps
    end
  end
end
