require 'date'

class Api::FlightsController < ApplicationController

  skip_authorize_resource :only => [:index, :show]
  skip_authorization_check 

=begin

  Render all of the flights, this will just be an example route
  The json form of the response is

  {"flights":[{ "id":178523975,"flight_number":"DDD111",
                "price":1340,"seats_available":"25","departure_time":"64",
                "arrival_time":"1300","origin":"Orange","destination":"Orgeon",
                "flight_time":2700}, ... ]


  def index


  Helpful information used when creating the below

    # Search will need to be done here and accept params
    # Rails.logger.info(params)

    # Started GET "/api/flights?
    #     originCode=HBA&
    #     destinationCode=VIE&
    #     departureDate=25-05-2015&
    #     returnDate=27-05-2015&
    #     ticketClass=&
    #     numberOfPeople=4" 

    # render json: Flight.take(10)
    
    # formatted_date = date.strftime('%a %b %d %H:%M:%S %Z %Y')

    tryDate = DateTime.parse(params['departureDate']).utc
    befDate = tryDate.advance(:minutes => -1)

    affDate = tryDate.advance(:days => 1)
    affDate = affDate.advance(:minutes => -1)

    #puts "Aff date #{affDate}"
    #puts "bff date #{befDate}"

    befDate = befDate.strftime('%Y-%m-%d %H:%M:%S UTC')
    affDate = affDate.strftime('%Y-%m-%d %H:%M:%S UTC')
    
    # render json: Flight.departs_on_day(befDate, affDate)
    render json: Flight.origin(params['originCode']).departs_on_day(befDate, affDate)

  end
=end

  def index

    # We will now load up a selection of flights variable
    num_flights = [1..10].sample

    flights = Array.new

    num_flights.each do |val|

      # Elms is the subarray of flights
      elems = Flight.take(200).sample( [1,2,3].sample )

      # For now, the top level information will just be taken from the composite information
      # The flight number will be the flight number of the first flight
      # origin and destination will simply be the initial origin and the final destination
      # price will be the composite price
      # seats available will be the floor of the seats available
      # The assumed ticket class will be economy
      # We are also going to resave the ticket class into the trip, so that
      # we have the information when we need to purchase or save things

      price = 0
      seats_available = elems.first.ticket_availabilities.min_seats(1).first.seats_available
      total_duration = 0

      # Set ticket class to sent class or ECO if its nil in params
      ticket_class = params['ticketClass']
      ticket_class ||= 'ECO'

      elems.each do |flight|
        available = flight.ticket_availabilities.min_seats(1).first
        price += available.price
        total_duration += flight.flight_time
        if available.seats_available <= seats_available
          seats_available = available.seats_available
        end
      end

      trip = {
        id: elems.first.id,
        flightNumber: elems.first.flight_number,
        price: price,
        departureTime: elems.first.departure_time,
        arrivalTime: elems.last.arrival_time,
        seatsAvailable: seats_available,
        flightTime: total_duration,
        origin: elems.first.origin.destination_code,
        destination: elems.last.destination.destination_code,
        isReturnFlight: [true, false].sample,
        ticketClass: ticket_class,
        legs: elems
      }

      flights.push(trip)

    end

    render json: flights

    end

  def show
    render json: Flight.find(params[:id])
  end

  # Action that maps to a purchase!
  # We will expect
    # some kind of user id
    # flight/s :: ids
    # ticket class that the purchase related to
    # ticket_type that the purchase relates to
  # We require these in order to decrement the availability associated with that flight
  def purchase

    print("Purchase Call Params!: " + params )

  end

end
