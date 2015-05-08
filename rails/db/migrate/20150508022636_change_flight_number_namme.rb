class ChangeFlightNumberNamme < ActiveRecord::Migration
  def change
  	rename_column :flights, :flightNumber, :flight_number
  end
end
