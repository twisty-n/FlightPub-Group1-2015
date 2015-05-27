# Authors: msikkema
# FlightPath class
# This is a datatype that represents a possible path, via a series
# of connecting flights and their destination

require 'data_types/destination_connection'

class FlightPath
	
	# ------------------------------- Class Initialiser --------------------------------- #
	
	def initialize
		@origin
		@internal_data = Array.new			# The array of DestinationConnections delineates the path, minus the origin
	end
	
	# ------------------------------- Getters and setters --------------------------------- #
	
	attr_accessor :origin, :internal_data
	
	
	# ------------------------------- Class Methods --------------------------------- #
	
	# This function returns the origin
	def get_origin
		@origin
	end
	
	# This function returns the final destination in this path
	def get_final_destination
		return @internal_data.last.destination
	end
	
	# This two functions add a new destinationConnection to the array
	def add_dc(input)
		@internal_data.push(input)
	end
	
	# This functino also adds a new DestinationConnection, but creates it first
	def add_manual(input_flight, input_destination)
		input_destination_connect = DestinationConnection.new(input_flight, input_destination)
		@internal_data.push(input_destination_connect)
	end
	
	# This function returns the number of connecting flights
	def get_no_connecting_flights
		return @internal_data.length
	end
	
	# This function returns the number of stops
	def get_no_of_stops
		return ((self.get_no_connectingflights) - 1)
	end
	
	# This function returns a string containing the contents.
	# mostly for debugging purposes.
	def to_s
		output = ''
		
		# Check if there is no origin, and give it the default string if so
		if @origin == nil
			@origin = '<NO ORIGIN>'
		end
		
		output += @origin
		
		@internal_data.each do |x|
			output += "\n Then \n"
			output += x.flight + " to " + x.destination
		end
		
		return output
		
	end #eof print function
	
	#check if the path is empty
	def empty?
		if @internal_data.empty? and @origin == nil
			return true
		else
			return false
		end
	end # eof empty? method
end