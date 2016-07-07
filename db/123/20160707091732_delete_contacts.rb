class DeleteContacts < ActiveRecord::Migration[5.0]
  def up
    drop_table :contacts
    create_table :contacts do |t|
      t.string :contact_type
      t.string :value
      t.string :comment
      t.integer :representative_id
      t.timestamps
    end

  end
end
