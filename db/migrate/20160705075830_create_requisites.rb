class CreateRequisites < ActiveRecord::Migration[5.0]
  def change
    create_table :requisites do |t|
      t.string :name
      t.string :value
      t.integer :product_id
      t.timestamps
    end
  end
end
