# Authors: msikkema
# FlightPath class
# This is a datatype that represents a possible path, via a series
# of connecting flights and their destination

require 'data_types/destination_connection'

class FlightPath
	
	# ------------------------------- Class Initialiser --------------------------------- #
	
	def initialize(input_origin, input_dc)
		@origin = input_origin
		@dc = input_dc				# The last DC (the dc links the other DCs)
	end
	
	# ------------------------------- Getters and setters --------------------------------- #
	
	attr_accessor :origin, :dc
	
	
	# ------------------------------- Class Methods --------------------------------- #
	
	def get_array

		# Flights go here
		results = Array.new

		# Start at the first DC.
		current_dc = @dc

		while !(current_dc.previous_dc == nil)

			results.push(current_dc.flight)

			current_dc = current_dc.previous_dc
		end

		# Reverse the array
		results.reverse!

	end

	# This function returns the origin
	def get_origin
		@origin
	end
	
	# This function returns the final destination in this path
	def get_dc
		return @dc
	end
	
	
	# This function returns the number of connecting flights
	def get_no_connecting_flights
		# TODO
	end
	
	# This function returns a string containing the contents.
	# mostly for debugging purposes.
	def to_s
		output = "\n --------------Flight Path object----------------- \n"
		
		# Check if there is no origin, and give it the default string if so
		if @origin == nil
			@origin = '<NO ORIGIN>'
		end
		


		current_dc = @dc
		while !(current_dc.previous_dc == nil)
			output += "\nNext Connection:\n"
			output += current_dc.to_s
			current_dc = current_dc.previous_dc
		end
		
		#lastly, add the origin
		output += "\n Origin: " + @origin.airport
		
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