# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create some basic flight seeds for the API testing stuff
# Replace this later with a flights fixture thang
Flight.create(flight_number:   'AAA111',
              price:          '8456',
              seatsAvailable: '10',
              departureTime:  '2400',
              arrivalTime:    '1300')

Flight.create(flight_number:   'BBB111',
              price:          '852',
              seatsAvailable: '9',
              departureTime:  '1200',
              arrivalTime:    '1300')

Flight.create(flight_number:   'CCC111',
              price:          '963',
              seatsAvailable: '10',
              departureTime:  '1200',
              arrivalTime:    '1300')

Flight.create(flight_number:   'DDD111',
              price:          '1340',
              seatsAvailable: '25',
              departureTime:  '0100',
              arrivalTime:    '1300')

Flight.create(flight_number:   'SEX111',
              price:          '420',
              seatsAvailable: '100',
              departureTime:  '1200',
              arrivalTime:    '1300')

Flight.create(flight_number:   'SEX222',
              price:          '120',
              seatsAvailable: '1',
              departureTime:  '1200',
              arrivalTime:    '1300')


# To specify our own Fixtures, use a thing similar to below, 
# changing the 'resource.yml' and Rsource.create! as needed

# Load our fixture for Country data

