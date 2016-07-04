class CreateMlCatalogs < ActiveRecord::Migration[5.0]
  def change
    create_table :ml_catalogs do |t|
      t.string :id_xml
      t.string :name
      t.string :changes
      t.integer :owner_id
      t.integer :classifier_id
      t.timestamps
      t.timestamps
    end
  end
end
