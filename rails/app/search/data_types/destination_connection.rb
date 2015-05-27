# Authors: msikkema
# DestinationConnection class
# This is a datatype that represents a connecting flight and its destination city.

class DestinationConnection

	# ------------------------------- Initialiser --------------------------------- #
	
	def initialize(input_flight, input_destination)
		@destination = input_destination
		@flight = input_flight
	end
	
	# ------------------------------- getters and setters --------------------------------- #
	
	attr_accessor :destination, :flight
	
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
		
		if @flight != nil
			output += "Flight: " + @flight.flight_number + " " + @flight.id.to_s + "\n"
		end
		
		if @destination != nil
			output += "Destination airport: " + @destination.airport + "\n\n"
		end
		
		return output
		
	end # eof to string method
end