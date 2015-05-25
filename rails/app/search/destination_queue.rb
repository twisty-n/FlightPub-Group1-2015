# Authors: msikkema
# DestinationQueue class
# This class works as a queue for the search algorithm, but with some
# extra sparkly magical features

class DestinationQueue
	
	# ------------------------------- Class Initialiser --------------------------------- #
	
	def initialize
		@internal_queue = Array.new
	end
	
	
	# ------------------------------- Class methods --------------------------------- #
	
	# This method adds a destination, and the flight that got there.
	# BUT NOT if it's a duplicate
	def add(input_dc)
	
		# assume the flight being added is not a duplicate to begin with
		is_duplicate = false
		
		# check the internal array for a duplicates
		@internal_queue.each do |x|
			# Checking each internal dc
			if x.flight == input_dc.flight and x.destination == input_dc.destination
				# found a duplicate!!
				is_duplicate = true
			end
		end
		
		#if no duplicates, add to array
		if !is_duplicate
		@internal_queue.push(input_dc)
		end
		
		#otherwise, do nothing.
		return nil
		
	end
	
	# Returns the first flight/destination pair
	def get_next
		return @internal_queue.shift
	end
	
	# Returns a string containing this objects contents
	def print
		output = ''
		
		# get details from each input
		@internal_queue.each do |x|
			output += 'Flight: ' + x.flight + " Destination: " + x.destination + "\n"
		end
		
		return output
	end
	
	# Checks if data structure is empty
	def empty?
		return @internal_queue.empty?
	end
end