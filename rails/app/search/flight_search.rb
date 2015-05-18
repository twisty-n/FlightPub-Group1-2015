# This class performs the search functionality in the assignment. It interfaces with the search
# API. To alter the search algorithm, replace this file, and don't touch anything else.
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
				


	def self.speak
		'This is a string from the search class'
	end
	
end