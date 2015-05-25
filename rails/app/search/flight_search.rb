# Authors: msikkema
# FlightSearch class
# This class performs the algorithmic part of the search, with significant help from
# other classes.

require 'errors/invalid_input_error'
require 'data_types/flight_path'
require 'data_types/destination_connection'
require 'reachable'
	
class FlightSearch

	# ------------------------------- Static Variables --------------------------------- #

	@@time_counter = 0
	
	# ------------------------------- Static methods --------------------------------- #
	
	# Ruby has surprisingly poor support for class variables, need to make the accessors manually.
	
	def self.get_time()
		return @@time_counter
	end
	
	def self.set_time(input_time)
		@@time_counter = input_time
	end
	
	# ------------------------------- Class methods --------------------------------- #
	
	# This is the guts of the rails side, it takes in two arguments:
	# origin: This is the starting location and
	# target: The destination we wish to get to
	def self.search(origin, target)
		
		# Set up the data structures:
		dest_queue = DestinationQueue.new		# This holds the destinations to check
		found_paths = Array.new					# This holds the ID'd flight paths
		discovered_nodes = Array.new			# This holds the discovered nodes
		
		# Add the first destination to the queue to check. No connecting flight, so it's nil.
		des_queue.add(DestinationConnection.new(nil, origin))
		
		# The while loop that runs while there are nodes to check:
		while !dest_queue.empty? do
			
		end #eof while loop that runs while there are nodes to check
		
		puts 'End of the search method'
		return nil #Clears useless info being returned
	end #eof search method
end