# Authors: msikkema
# Test class
# This class performs is for testing

require 'errors/invalid_input_error'
require 'data_types/flight_path'
require 'data_types/destination_connection'
require 'reachable'

class Test

	# ------------------------------- Logger --------------------------------- #
	
	old_logger = ActiveRecord::Base.logger
	ActiveRecord::Base.logger = nil
	
	# ------------------------------- Class Functions --------------------------------- #
	
	# This tests the destination connections
	def self.destination_connection_test
		puts '=============== Now running the DestinationConnection test: ================'
		
		#Variables needed for this test
		@destination_array = Array.new
		num = 1
		
		# Create some destination connections
		until num == 11 do
			newConnection = DestinationConnection.new('flight: ' + num.to_s,'Destination: ' + num.to_s)
			@destination_array.push(newConnection)
			num += 1
		end
		
		puts "What was just made:\n"
		@destination_array.each do |x|
			puts x.flight
			puts x.destination
			puts "----------------------- \n"
		end
		
		puts '======== DestinationConnection test has finished.'
		
		# To get rid of the useless output
		return nil
	end
	
	
	
	# This function tests the FlightPath class
	def self.flight_path_test
		puts '=============== Now running the FlightPath test: ================'
		
		#variables needed for the test
		@sample_path = FlightPath.new
		
		# if @destination array is empty, fill it using the previous test
		if @destination_array == nil
			destination_connection_test
		end
		
		# Now load the @destination_array into a FlightPath object:
		@destination_array.each do |x|
			@sample_path.add_dc(x)
		end
		
		#print out the flight path
		puts @sample_path.print
		
		puts 'This should return false'
		puts @sample_path.empty?
		puts 'This should return true'
		empty_path = FlightPath.new
		puts empty_path.empty?
		
		# Makes the output clearer
		return nil
	end
	
	# This method tests the destination_queue class
	
	def self.destination_queue_test
		puts '=============== Now running the FlightPath test: ================'
		
		#Variables needed for this test
		test_queue = DestinationQueue.new
		num = 1
		
		# Create some destination connections to the queue
		until num == 11 do
			newConnection = DestinationConnection.new('flight: ' + num.to_s,'Destination: ' + num.to_s)
			test_queue.add(newConnection)
			num += 1
		end
		
		#print out the contents
		puts 'Data inside the DestinationQueue:'
		puts test_queue.print
		
		#now test it using identical data
		test_queue = DestinationQueue.new
		num = 1
		
		puts 'This should only print out a single flight:'
		
		# Create some destination connections to the queue
		until num == 11 do
			newConnection = DestinationConnection.new('duplicate', 'duplicate' )
			test_queue.add(newConnection)
			num += 1
		end
		
		puts test_queue.print
		
		return nil
	end # eof destination queue test
	
	def self.active_record_test
		puts '================== Active record test ================'
		
		test_destination = Destination.first
		
		puts 'Lets try to print out the results of sydney: '
		
		jack_reacher = Reachable.new
		
		raw_dc = jack_reacher.get_reachables(test_destination)
		
		raw_dc.each do | dc |
		
			puts "Flight number: " + dc.flight.flight_number + "\n"
			puts "Flight ID: " + dc.flight.id.to_s
			puts "Destination airport: " + dc.destination.airport
			puts "\n ===================================== \n"
			
		end

		
		return nil # Clears useless data
	end # eof active record test
	
	def self.search_test
	
		puts "================== Search Test =================="
		
		origin = Destination.find_by(airport: 'Sydney')
		
		destination = Destination.find_by(airport: 'Melbourne')
		
		puts "The origin is: " + origin.airport + " and the destination is: " + destination.airport
		
		FlightSearch.bfs(origin, destination, 0)
		
	end #eof search test
	
	# This test is for the destination queue
	def self.dest_queue_test
	
		puts '============= DestinationQueue test ==============='
		
		puts "lets make a new DestinationQueue"
		dq = DestinationQueue.new
		
		puts "Done. Now lets make some random DC object"
		dc = DestinationConnection.new(Flight.first, Destination.first)
		
		puts 'The DC we just made is: ' + dc.to_s
		
		puts 'Making a couple of dc objects'
		
		dc2 = DestinationConnection.new(Flight.first, Destination.first)
		dc3 = DestinationConnection.new(Flight.first, Destination.first)
		dc4 = DestinationConnection.new(Flight.first, Destination.first)
		dc5 = DestinationConnection.new(Flight.first, Destination.first)
		dc6 = DestinationConnection.new(Flight.last, Destination.last)
		dc7 = DestinationConnection.new(Flight.last, Destination.last)
		dc8 = DestinationConnection.new(Flight.last, Destination.last)
		
		puts 'The dest queue should report a size of two:'
		
		dq.add(dc)
		dq.add(dc2)
		dq.add(dc3)
		dq.add(dc4)
		dq.add(dc5)
		dq.add(dc6)
		dq.add(dc7)
		dq.add(dc8)
		
		puts dq.size
		
		puts 'Printing the queue:'
		puts dq.to_s
		
		puts "This should print true:"
		dc9 = DestinationConnection.new(Flight.last, Destination.last)
		
		puts dq.include?(dc9)
		return nil # Clears useless data
	end # eof dest queue test
end