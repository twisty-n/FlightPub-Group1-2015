# This class performs the search functionality in the assignment. It interfaces with the search
# API. To alter the search algorithm, replace this file, and don't touch anything else.

require 'errors/invalid_input_error'
require 'flight_path'
	
class FlightSearch

# ------------------------------- Getters and Setters --------------------------------- #

attr_accessor :output_on
				
# ------------------------------- Class Variables --------------------------------- #

output_on = true		#Make true 


# ------------------------------- Class Methods --------------------------------- #

	# This is a test method
	def self.speak
		'This is a string from the search classss'
	end
	
	
	# This method is for internal use, prints out a pretty flight syntax.
	def self.printFlights(input_array)
		
#		array_of_hash_flights = input_array.as_json
		
		input_array.each do |value|
			# Load the flight from the array
			flight = value
			# Print out details of the flight
			flight.each do |k,v|
				puts k.to_s + ":		" + v.to_s
			end
			puts "\n ---------------------------------------------------- \n"
		end
	
	end	#eof search function
	
	
	# This is the main search method. 
	# Accepts a target city and origin as an argument (at the moment, more params later)
	# and then runs a breadthfirst search on it
	def self.search(origin, target)
	
		# Turn off SQL output
		old_logger = ActiveRecord::Base.logger
		ActiveRecord::Base.logger = nil
	
		puts 'The target is: ' + target + " And the origin is: " + origin
		
		# verify the input is not blank or empty
		if target == nil || target.blank?
			raise InvalidInputError "The input is invalid"
		end
		
		puts 'The input is acceptable.'
		
		# create the data structures needed:
		candidate_queue = Array.new			# List of cities to check
		discovered_array = Array.new		# List of cities known
		candidate_place	= origin			# Temporary object to check. Begin with origin.
		paths = Array.new		# Array of identified flight paths
		
		puts 'Data structures now created.'
		
		# Label origin as known to exist, and make it the first candidate to check.
		discovered_array << candidate_place
		candidate_queue << candidate_place
		
		puts 'Now starting the search algorithm. Current candidate is:'
		p candidate_queue
		
		# Now search my pretties! SEARCH!!!
		while candidate_queue.empty? == false do
			#Get the next candidate to check
			current_place = candidate_queue.shift
			#Get the flights that leave
			leaving_flights = get_leaving_flights(current_place)
			# Print off the candidate destinations if they are not visited:
			leaving_flights.each do |flight|
				flight.each do |k,v|
					if k == "destination" and !discovered_array.include? v
						puts 'Connecting node: ' + v
						# Add this place to the queue of places to check
						candidate_queue << v
						# Then add this place to list of discovered
						discovered_array << v
					end
				end
			end		
		end
		
		
		
	puts 'The search function has finished.'
	end	#eof search function
	
	
	# This method returns an array of adjacent airports
	def self.get_adjacent_airports(airport)
	end	#eof get adjacent airports function
	
	
	# This method returns an array of flights leaving a target city
	def self.get_leaving_flights(airport)
		raw_array = Array.new
		
		Flight.where(origin: airport).find_each do |flight|
			raw_array << flight
		end
		raw_array = raw_array.as_json
		return raw_array
	end	# eof get leaving flights function
	
end