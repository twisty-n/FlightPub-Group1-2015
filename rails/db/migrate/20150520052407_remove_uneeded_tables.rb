class RemoveUneededTables < ActiveRecord::Migration
  def change
    #drop_table :flights_raws
    #drop_table :availabilities
    drop_table :prices
  end
end
