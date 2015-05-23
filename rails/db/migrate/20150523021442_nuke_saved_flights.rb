class NukeSavedFlights < ActiveRecord::Migration
  def change
    drop_table :saved_flights
  end
end
