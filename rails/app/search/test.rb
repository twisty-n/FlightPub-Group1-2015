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
		
		test_flight = Destination.first
		
		puts 'Lets try to print out the results of sydney: '
		
		jack_reacher = Reachable.new
		
		raw_dc = jack_reacher.get_reachables(test_flight)
		
		raw_dc.each do | dc |
		
			puts "Flight number: " + dc.flight.flight_number + "\n"
			puts "Flight ID: " + dc.flight.id.to_s
			puts "Destination airport: " + dc.destination.airport
			puts "\n ===================================== \n"
			
		end

		
		return nil # Clears useless data
	end # eof active record test
end