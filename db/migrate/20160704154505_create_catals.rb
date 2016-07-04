class CreateCatals < ActiveRecord::Migration[5.0]
  def change
    create_table :catals do |t|
      t.string :id_xml
      t.string :name
      t.string :changes
      t.integer :owner_id
      t.integer :classifier_id
      t.timestamps
    end
  end
end
