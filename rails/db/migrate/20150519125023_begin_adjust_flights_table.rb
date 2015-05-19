class BeginAdjustFlightsTable < ActiveRecord::Migration
  def change
    #remove_column :flights, :price
    #remove_column :flights, :seats_available
    #rename_column :flights, :trip_length, :flight_time

    change_table :flights do |f|
        f.references :airlines, index: true
    end
  end
end
