# Authors: msikkema
# DestinationConnection class
# This is a datatype that represents a connecting flight and its destination city.

class DestinationConnection

	# ------------------------------- Initialiser --------------------------------- #
	
	def initialize(input_flight, input_destination, previous_dc)
		@destination = input_destination
		@flight = input_flight
		@previous_dc = previous_dc
	end
	
	# ------------------------------- getters and setters --------------------------------- #
	
	attr_accessor :destination, :flight, :previous_dc
	
	# ------------------------------- class methods --------------------------------- #
	
	# This method compares this dc to another for equality
	def equal?(dc)
		equivalent = false
		
		if @flight.id == dc.flight.id && @destination.id == dc.destination.id
			equivalent = true
		end
		
		return equivalent
	end
	
	# This method prints out the contents of the DC
	def to_s
	
		output = "DC object: \n" 
		
		if @flight != nil and @flight.id != nil
			output += "Flight: " + @flight.flight_number + " " + @flight.id.to_s + " Departs: " + @flight.departure_time.to_s + "arrives: " + @flight.arrival_time.to_s + "\n"
		end
		
		if @destination != nil
			output += "Destination airport: " + @destination.airport + "\n\n"
		end
		
#		if !(@previous_dc == nil)
#			output += "\n *** LINKED FROM *** \n"
#			output += @previous_dc.to_s
#		end
		
		return output
		
	end # eof to string method
end