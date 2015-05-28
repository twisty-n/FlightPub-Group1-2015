# Authors: msikkema
# Reachable class
# This class is cruicial to the workings of the flight search.
# flight_search.rb itself is rather stupid, it's just the algorithm,
# this class determines what flights can be actually reached from a given
# point and then returns them, for use by the algorithm.
# takes price, time into account so far.

class Reachable

	# ------------------------------- Initialiser --------------------------------- #
	
	def initialize
	
		@start_time = FlightSearch.get_time			# Starting time
		
	end #eof initialiSer
	
	
	# ------------------------------- Class Functions --------------------------------- #
	
	# This function returns the reachable flights, given preset parameters
	def get_reachables(current_node, requesting_dc)
		
		# Step 1: Set up data structures
		raw_results = Array.new
		
		# Step 2: Get the raw matching flights, making sure they come after the previous
#		Flight.where(origin_id: current_node.id).find_each do | flight |		# The old SQL query
		
		# Check if the requesting_dc is the very first node, because it has no flight!
		if requesting_dc.flight == nil
			requesting_dc.flight = Flight.new
			requesting_dc.flight.arrival_time = FlightSearch.get_start_time
		end
		# Time ranges:
		# 1 day => 86400
		# 2 days => 172800
		# 3 days => 259200
		
		# Calculate the time range
		max_stopover_time = requesting_dc.flight.arrival_time + 172800
		Flight.where(origin_id: current_node.id).where("departure_time > ?", requesting_dc.flight.arrival_time).where("departure_time <= ?", max_stopover_time ).find_each do | flight |
			# Step 2a: Add matching flights to the results
			
			# get the destination
			found_destination = Destination.find(flight.destination_id)
			# Add the flight + destination as a DC object
			input_dc = DestinationConnection.new(flight, found_destination, requesting_dc )
			raw_results.push(input_dc)
			
		end # eof the loop that finds matching flights
		
		# Step 3: return it
		return raw_results
	end # eof get_reachables function
end