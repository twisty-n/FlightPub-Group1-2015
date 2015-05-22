class FixFlightColumnNames < ActiveRecord::Migration
  def change

  	rename_column :flights, :departureTime, :departure_time
  	rename_column :flights, :arrivalTime, :arrival_time
  	rename_column :flights, :seatsAvailable, :seats_available


  end
end
