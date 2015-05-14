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
#Flight.create(flight_number:            'AAA111',
#              price:                    '8456',
#              seatsAvailable:           '10',
#              departureTime:            '2400',
#              arrivalTime:              '1300',
#              trip_length:              '5500',
#              destination:              'Sydney',
#              origin:                   'Tokyo',
#              has_stopover:             false)
##              stopover_arrival_time:    null,
##              stopover_departure_time:  null,
##              stopover_destination:     null,
##              stopover_origin:          null)
#
#Flight.create(flight_number:            'AAA112',
#              price:                    '9000',
#              seatsAvailable:           '11',
#              departureTime:            '2300',
#              arrivalTime:              '1500',
#              trip_length:              '7500',
#              destination:              'Tokyo',
#              origin:                   'Sydney',
#              has_stopover:             'true',)
#              stopover_arrival_time:    '2200',
#              stopover_departure_time:  '2300',
#              stopover_destination:     'Darwin',
#              stopover_origin:          'Sydney')


# To specify our own Fixtures, use a thing similar to below, 
# changing the 'resource.yml' and Rsource.create! as needed

# Load our fixture for Country data

