# This class performs the search functionality in the assignment. It interfaces with the search
# API. To alter the search algorithm, replace this file, and don't touch anything else.
class FlightSearch < ActiveRecord::Base

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
		'This is a string from the search class'
	end
	
	
	# This method does a breadth first search of the flights table.
	# It will return an array of path objects that match
	def self.search
		raw_flights = Flight.all
		
		puts "Converting flight activerecord associations to hash..."
		hash_flights = raw_flights.as_json
		puts "Preparing to print out the newly created hash..."
		puts hash_flights
		
	
	end	#eof search function
	
	
end