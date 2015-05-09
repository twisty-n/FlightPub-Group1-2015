class MakeCountryCodesUnique < ActiveRecord::Migration
  def change
    add_index :countries, :country_code_2, :unique => true
    add_index :countries, :country_code_3, :unique => true
  end
end
