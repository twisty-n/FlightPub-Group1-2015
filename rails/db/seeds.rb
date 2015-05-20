# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create some basic flight seeds for the API testing stuff
# Replace this later with a flights fixture thang
# NOTE: fields that need to be null in the table should not have an entry in the key/value pairs.
Flight.create(
			  id: 						'1',
			  flight_number:            'AAA111',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '2400',
              arrivalTime:              '1300',
              trip_length:              '5500',
              destination:              'Newcastle',
              origin:                   'Sydney',
              is_composite_flight:      false)

Flight.create(
			  id: 						'2',
			  flight_number:            'AAA111',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '1400',
              arrivalTime:              '1700',
              trip_length:              '5500',
              destination:              'Darwin',
              origin:                   'Newcastle',
              is_composite_flight:      false)	
			  
Flight.create(
			       id: 						'3',
			        flight_number:            'AAA111',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '2400',
              arrivalTime:              '1700',
              trip_length:              '5500',
              destination:              'Darwin',
              origin:                   'Sydney',
              is_composite_flight:      true,
			  leg_1_id:					'1',
			  leg_2_id:					'2')	
			  
Flight.create(
			  id: 						'4',
			  flight_number:            'BBB111',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '2400',
              arrivalTime:              '1300',
              trip_length:              '5500',
              destination:              'Jakarta',
              origin:                   'Darwin',
              is_composite_flight:      false)

Flight.create(
			  id: 						'5',
			  flight_number:            'BBB111',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '1400',
              arrivalTime:              '1700',
              trip_length:              '5500',
              destination:              'Surabaya',
              origin:                   'Jakarta',
              is_composite_flight:      false)	
			  
Flight.create(
			  id: 						'6',
			  flight_number:            'BBB111',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '2400',
              arrivalTime:              '1700',
              trip_length:              '5500',
              destination:              'Surabaya',
              origin:                   'Darwin',
              is_composite_flight:      true,
			  leg_1_id:					'4',
			  leg_2_id:					'5')		
			  
Flight.create(
			  id: 						'7',
			  flight_number:            'BBB112',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '2400',
              arrivalTime:              '1700',
              trip_length:              '5500',
              destination:              'Newcastle',
              origin:                   'Rome',
              is_composite_flight:      false)
              
Country.create(
  country_name:   'Surabaya'
)			

Country.create(
  country_name:   'Darwin'
)	

Country.create(
  country_name:   'Newcastle'
)		  	  		  	


# To specify our own Fixtures, use a thing similar to below, 
# changing the 'resource.yml' and Rsource.create! as needed

# Load our fixture for Country data

