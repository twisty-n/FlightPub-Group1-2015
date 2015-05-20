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

# ------------------------------- Flights --------------------------------- #
Flight.create(
			  id: 						'1',
			  flight_number:            'AAA111',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '2400',
              arrivalTime:              '1300',
              trip_length:              '5500',
              destination:              'NWC',
              origin:                   'SYD',
              is_composite_flight:      false)

Flight.create(
			  id: 						'2',
			  flight_number:            'AAA111',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '1400',
              arrivalTime:              '1700',
              trip_length:              '5500',
              destination:              'DAR',
              origin:                   'NWC',
              is_composite_flight:      false)	
			  
Flight.create(
			       id: 						'3',
			        flight_number:            'AAA111',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '2400',
              arrivalTime:              '1700',
              trip_length:              '5500',
              destination:              'DAR',
              origin:                   'SYD',
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
              destination:              'JAK',
              origin:                   'DAR',
              is_composite_flight:      false)

Flight.create(
			  id: 						'5',
			  flight_number:            'BBB111',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '1400',
              arrivalTime:              '1700',
              trip_length:              '5500',
              destination:              'SUR',
              origin:                   'JAK',
              is_composite_flight:      false)	
			  
Flight.create(
			  id: 						'6',
			  flight_number:            'BBB111',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '2400',
              arrivalTime:              '1700',
              trip_length:              '5500',
              destination:              'SUR',
              origin:                   'DAR',
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
              destination:              'NWC',
              origin:                   'ROM',
              is_composite_flight:      false)
              
Flight.create(
			  id: 						'8',
			  flight_number:            'BBB113',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '2400',
              arrivalTime:              '1700',
              trip_length:              '5500',
              destination:              'CDG',
              origin:                   'SYD',
              is_composite_flight:      false)
              
Flight.create(
			  id: 						'9',
			  flight_number:            'AJS001',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '2400',
              arrivalTime:              '1700',
              trip_length:              '5500',
              destination:              'SYD',
              origin:                   'SYD',
              is_composite_flight:      false)
              
Flight.create(
			  id: 						'10',
			  flight_number:            'AJS012',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '2400',
              arrivalTime:              '1700',
              trip_length:              '5500',
              destination:              'AMS',
              origin:                   'NWC',
              is_composite_flight:      false)
              
Flight.create(
			  id: 						'11',
			  flight_number:            'AJS013',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '2400',
              arrivalTime:              '1700',
              trip_length:              '5500',
              destination:              'AMS',
              origin:                   'NWC',
              is_composite_flight:      false)

Flight.create(
			  id: 						'12',
			  flight_number:            'AJS017',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '2400',
              arrivalTime:              '1700',
              trip_length:              '5500',
              destination:              'HEL',
              origin:                   'AMS',
              is_composite_flight:      false)
              
Flight.create(
			  id: 						'13',
			  flight_number:            'AJS222',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '2400',
              arrivalTime:              '1700',
              trip_length:              '5500',
              destination:              'LAX',
              origin:                   'HEL',
              is_composite_flight:      false)
              
Flight.create(
			  id: 						'14',
			  flight_number:            'INT666',
              price:                    '8456',
              seatsAvailable:           '10',
              departureTime:            '2400',
              arrivalTime:              '1700',
              trip_length:              '5500',
              destination:              'ROM',
              origin:                   'LAX',
              is_composite_flight:      false)
              
# ------------------------------- Countries --------------------------------- #
              
#Country.create(
#  country_name:   'SUR'
#)			
#
#Country.create(
#  country_name:   'SYD'
#)		
#
#Country.create(
#  country_name:   'DAR'
#)	
#
#Country.create(
#  country_name:   'NWC'
#)		
#
#Country.create(
#  country_name:   'ROM'
#)	  	  		  	


# ------------------------------- Destination --------------------------------- #

Destination.create(
  destination_code:   'SUR',
  airport:            'Surabaya'
)

Destination.create(
  destination_code:   'SYD',
  airport:            'Sydney'
)

Destination.create(
  destination_code:   'NWC',
  airport:            'Newcastle'
)

Destination.create(
  destination_code:   'CDG',
  airport:            'France'
)

Destination.create(
  destination_code:   'AMS',
  airport:            'Amsterdam'
)

Destination.create(
  destination_code:   'HEL',
  airport:            'Helsinki'
)

Destination.create(
  destination_code:   'LAX',
  airport:            'LA'
)

Destination.create(
  destination_code:   'ROM',
  airport:            'Rome'
)



# To specify our own Fixtures, use a thing similar to below, 
# changing the 'resource.yml' and Rsource.create! as needed

# Load our fixture for Country data

