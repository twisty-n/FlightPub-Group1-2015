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
	
	
	# ------------------------------- Initialiser --------------------------------- #
	
		# Empty! This class only functions as a collection of static functions.
	
	# ------------------------------- Class Functions --------------------------------- #
	
	# This is the guts of the rails side, it takes in two arguments:
	# origin: This is the starting location and
	# target: The destination we wish to get to
	# start_time: the time from which point the algorithm begins.
	def self.bfs(origin, target, start_time)
		
		# Set up the data structures:
		dest_queue = DestinationQueue.new		# This holds the destinations to check
		found_paths = Array.new					# This holds the ID'd flight paths
		discovered_nodes = DestinationQueue.new	# This holds the discovered nodes
		reach = Reachable.new					# Gets the appropriate reachable flight and nodes
		
		# Add the first destination to the queue to check. No connecting flight, so it's nil.
		
		first_dc = DestinationConnection.new(nil, origin)
		dest_queue.add(first_dc)
		
		# Register the first node as discovered
		discovered_nodes.add(first_dc)
		
		# The while loop that runs while there are nodes to check:
		
		# debugging output
		current_level = 0
		
		while !dest_queue.empty? do
		
			current_level += 1
		
			current_destination_dc = dest_queue.get_next	# Get the first flight/destination pair
		
			results = reach.get_reachables(current_destination_dc.destination)
			
			# add these destination connections to the queue
			# testing: Stop if the destination is found
			
			results.each do |dc|
				if
					dc.destination.airport.eql? target.airport
					puts "This flight arrives at the target: " + dc.destination.airport
				
				##
				##	The elsif statement isn't working because it's comparing
				##  Objects, and not their values!!
				##
				elsif !discovered_nodes.include? dc
					discovered_nodes.add(dc)
					dest_queue.add(dc)
				else
					puts 'This DC has been checked already.'
				end
			end
		
			
			puts 'The size of the destination queue is now ' + dest_queue.get_size.to_s
			puts 'Currently at level: ' + current_level.to_s
			
		end #eof while loop that runs while there are nodes to check
		
		puts 'End of the search method'
		return nil #Clears useless info being returned
	end # eof bfs_search method
	
	def self.dfs(origin, target, start_time)
		
		# setup data structures
		discovered_queue = DestinationQueue.new
		jack_reacher = Reachable.new
		
		# label the first node as discovered
		discovered_queue.add(origin)
		
		# get the next reachable DCs
		reachables = jack_reacher.get_reachables(discovered_queue.get_next)
		
		reachables.each do |dc|
			if target.id == dc.destination.id
				puts 'Target reached.'
			elsif !(discovered_queue.include?(dc))
				dfs(dc.destination, target, start_time)
			end
		end
		
		
		puts 'end of the dfs method'
		return nil
	end #eof dfs method
end