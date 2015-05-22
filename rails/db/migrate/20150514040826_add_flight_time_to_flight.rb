class AddFlightTimeToFlight < ActiveRecord::Migration
  def change
  	# Note that this will be measured in minutes
  	add_column :flights, :flight_time, :int
  end
end
