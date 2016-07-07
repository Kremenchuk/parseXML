class CreateContractors < ActiveRecord::Migration[5.0]
  def change
    create_table :contractors do |t|
      t.string :id_xml
      t.string :name
      t.string :role
      t.string :address
      t.string :post_index
      t.string :country
      t.string :region
      t.string :area
      t.string :city
      t.string :street
      t.string :build
      t.string :housing
      t.string :flat
      t.integer :personable_id
      t.string :personable_type
      t.timestamps
    end
  end
end
