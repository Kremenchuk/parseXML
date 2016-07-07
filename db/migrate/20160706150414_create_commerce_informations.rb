class CreateCommerceInformations < ActiveRecord::Migration[5.0]
  def change
    create_table :commerce_informations do |t|
      t.string :name_document
      t.string :version
      t.string :date
      t.timestamps
    end
  end
end
