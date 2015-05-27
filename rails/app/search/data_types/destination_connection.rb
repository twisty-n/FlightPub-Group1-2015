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
end