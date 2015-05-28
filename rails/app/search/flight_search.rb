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
	@@start_time = Time.now
	
	# ------------------------------- Static methods --------------------------------- #
	
	# Ruby has surprisingly poor support for class variables, need to make the accessors manually.
	
	def self.get_time()
		return @@time_counter
	end
	
	def self.set_time(input_time)
		@@time_counter = input_time
	end
	
	def self.get_start_time
		return @@start_time
	end
	
	def self.set_start_time(input)
		@@start_time = input
	end
	
	
	# ------------------------------- Initialiser --------------------------------- #
	
		# Empty! This class only functions as a collection of static functions.
	
	# ------------------------------- Class Functions --------------------------------- #
	
	# This is the guts of the rails side, it takes in two arguments:
	# origin: This is the starting location and
	# target: The destination we wish to get to
	# start_time: the time from which point the algorithm begins.
	def self.bfs(origin, target, start_time)
	
		puts "Starting BFS algorithm"
		
		# Setup the data structures
		discovered = DestinationQueue.new
		toProcess = DestinationQueue.new
		jack_reacher = Reachable.new
		graph_level = 0
		set_start_time(start_time)
		detected_paths = Array.new
		
		# Prepare the first DC. The flight is nil
		first_dc = DestinationConnection.new(nil, origin, nil)
		# Add the first DC to process and discovered
		discovered.add(first_dc)
		toProcess.add(first_dc)
		
		# Start the loop that crawls the graph
		while !(toProcess.empty?)  and graph_level < 7
			
			# Get the next node in the queue
			current_dc = toProcess.get_next()
			
			# Get the adjacent DCs
			adjacent_dc_list = jack_reacher.get_reachables(current_dc.destination, current_dc)
			
			# Process the adjacent DCs
			adjacent_dc_list.each do |dc|
				
				# Check if we found our destination
				if dc.destination.airport == target.airport
				
					# Destination located! Now we must create a flight path object
					puts "\n Path detected."
					
					# Create the flight path object:
					# Add the origin in (it's a separte data piece)
					found_path = FlightPath.new(origin, dc)
					
					detected_paths.push(found_path)
					
				else
				
					# Not our destination. Add to discovered (the DQ will not add it if it's already in there)
					discovered.add(dc)
					# Add to list to process
					toProcess.add(dc)
					
				end # eof if loop to check
			end # eof each subloop that checks the returned DC objects
			
			# Print out what percentage we are up to (assuming max 6 stops)
			
			print (graph_level.fdiv(6) * 100).to_s + '% '
			graph_level += 1
		end # eof while graph crawling loop
		
		
		
		puts 'End of the search method'
		return detected_paths
	end # eof bfs_search method
	
	# This method uses a depth first search
	def self.dfs(origin, target, start_time)
		
		# Might do later
		
		puts 'end of the dfs method'
		return nil
	end #eof dfs method
end