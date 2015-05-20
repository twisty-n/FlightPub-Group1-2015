# This class performs the search functionality in the assignment. It interfaces with the search
# API. To alter the search algorithm, replace this file, and don't touch anything else.

require 'errors/invalid_input_error'
	
class FlightSearch

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
		
		# create the data structures needed:
		candidate_queue = Queue.new			# List of cities to check
		discovered_array = Array.new		# List of cities known
		candidate_place						# Temporary object to check. Begin with origin.
		
		# Label origin as known to exist
		discovered_array << candidate_place
		candidate_queue << candidate_place
		
		#Now search my pretties! Search!
		while !candidate_place.empty?
			#Get the next candidate to check
			
		end
		
		
		
	end	#eof search function
	
end