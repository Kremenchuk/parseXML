class CreateDiscounts < ActiveRecord::Migration[5.0]
  def change
    create_table :discounts do |t|
      t.string :name
      t.string :name
      t.string :percent
      t.string :in_total
      t.integer :product_id
      t.timestamps
    end
  end
end
