class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :country_code_2
      t.string :country_code_3
      t.string :country_name
      t.string :alternate_name_1
      t.string :alternate_name_2
      t.string :mother_country_code_3
      t.text :mother_county_comment

      t.timestamps null: false
    end
  end
end
