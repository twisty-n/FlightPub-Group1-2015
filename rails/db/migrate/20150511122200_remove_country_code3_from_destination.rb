class RemoveCountryCode3FromDestination < ActiveRecord::Migration
  def change
    remove_column :destinations, :country_code_3
  end
end
