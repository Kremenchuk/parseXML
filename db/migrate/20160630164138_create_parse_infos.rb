class CreateParseInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :parse_infos do |t|
      t.string :id_xml
      t.timestamps
    end
  end
end
