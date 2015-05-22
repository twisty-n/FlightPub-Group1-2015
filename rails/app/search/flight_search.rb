# This class performs the search functionality in the assignment. It interfaces with the search
# API. To alter the search algorithm, replace this file, and don't touch anything else.

require 'errors/invalid_input_error'
	
class FlightSearch

# This is the basic algorithm, implemented in ruby and not MySQL. 
# It lacks important parameters atm (like times). It works like this:
# Step 1: x <- Origin
# Step 2: y <- Desired destination
# 
# Step 3: Mark X as a visited city
# Step 4: Check if any flights that depart X go to Y?
#			yes?
#				Return that flight.
#			No and there are linking cities that are not visited?
#				Go to first departing flight's destination.
#				x <- Flights destination
#				Run from step 3 on that destination city.
#			No, and all cities have been checked
#				Stop. Return "Finished."

#	GETTERS & SETTERS	#############################################

attr_accessor :output_on
				
#	CLASS VARIABLES		#############################################

output_on = true		#Make true 


#	CLASS METHODS		#############################################

	# This is a test method
	def self.speak
		'This is a string from the search classss'
	end
	
	
	# This method does a breadth first search of the flights table.
	# It will return an array of path objects that match
	def self.outputFlightsTable
		raw_flights = Flight.all
		
		puts "Converting flight activerecord associations to array of hash browns..."
		array_of_hash_flights = raw_flights.as_json
		puts "\n THE FLIGHT VALUES IN THE DATABASE ARE:\n"
		
		array_of_hash_flights.each do |value|
			
			# Load the flight from the array
			flight = value
			# Print out details of the flight
			flight.each do |k,v|
				puts k.to_s + ":		" + v.to_s
			end
			puts "\n ---------------------------------------------------- \n"
		end
	puts "\nEND OF FLIGHT VALUES\n"
	
	end	#eof search function
	
	
	# This is the main search method. 
	# Accepts a target city and origin as an argument (at the moment, more params later)
	# and then runs a breadthfirst search on it
	def self.search(target, origin)
	
		# verify the input is not blank or empty
		if target == nill || target.blank
			raise InvalidInputError "The input is invalid"
		end
	
	end	#eof search function
	
end