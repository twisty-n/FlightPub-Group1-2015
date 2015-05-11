class RemoveIndexOnCountryCodes < ActiveRecord::Migration
  def change
    remove_index :countries, :country_code_2
    remove_index :countries, :country_code_3

    #change_column :countries, :country_code_2, :unique
    #change_column :countries, :country_code_3, :unique
  end
end
