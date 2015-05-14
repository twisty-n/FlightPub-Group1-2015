class AddForeignKeyToFlights < ActiveRecord::Migration
  def change 
#    change_table :flights do |t|
      add_foreign_key :flights, :flights, column:  :leg_1_id, primary_key: :id
      add_foreign_key :flights, :flights, column:  :leg_2_id, primary_key: :id
  end  
end
