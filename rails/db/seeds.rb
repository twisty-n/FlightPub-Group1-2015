# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create some basic flight seeds for the API testing stuff

Flight.create(flightNumber:   'AAA111',
              price:          '1200',
              seatsAvailable: '10',
              departureTime:  '1200',
              arrivalTime:    '1300')

Flight.create(flightNumber:   'BBB111',
              price:          '1200',
              seatsAvailable: '9',
              departureTime:  '1200',
              arrivalTime:    '1300')

Flight.create(flightNumber:   'CCC111',
              price:          '1200',
              seatsAvailable: '10',
              departureTime:  '1200',
              arrivalTime:    '1300')
