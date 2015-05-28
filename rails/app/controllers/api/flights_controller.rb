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

    # Determine what to do based on the search query
    # Doing this until we can find a cleaner way via ember
    if params['q_type'] == 'promo'
      promo_flights_load and return
    end

    # We will now load up a selection of flights variable
    # 
    # These are our params
    #     # Started GET "/api/flights?
    #     originCode=HBA&
    #     destinationCode=VIE&
    #     departureDate=25-05-2015&
    #     returnDate=27-05-2015&
    #     ticketClass=&
    #     numberOfPeople=4" 
    #     
    
    # First run the search for departing flights
    depart_date = ActiveSupport::TimeZone["UTC"].parse( params['departureDate'] + ' 00:01am' )
    puts depart_date

    return_date = ActiveSupport::TimeZone["UTC"].parse( params['returnDate'] + ' 00:01am' )
    puts return_date

    depart_destination = Destination.find_by(destination_code: params['destinationCode'])
    depart_origin = Destination.find_by(destination_code: params['originCode'])

    depart_flight_paths = FlightSearch.bfs(depart_origin, depart_destination, depart_date)
    return_flight_paths = FlightSearch.bfs(depart_destination, depart_origin, return_date)

    # puts flight_paths.inspect
    journeys = Array.new
    # change this to operate on our departing flight paths and returning flight paths
    depart_flight_paths.each do |val|

      ticket_class = params['ticketClass']
      ticket_class ||= 'ECO'

      price = 0

      puts val.class.to_s
      puts val.to_s

      seats_available = val.get_array.first.ticket_availabilities.t_class(ticket_class).smallest_price.seats_available
      total_duration = 0


      # Operates on the individual flights in our flight paths
      val.get_array.each do |flight|
        
        # Set up the flight information
        print("The flight is #{flight.inspect}")
        ticket = flight.ticket_availabilities.t_class(ticket_class).smallest_price
        price += ticket.price
        total_duration += flight.flight_time
        if ticket.seats_available <= seats_available
          seats_available = ticket.seats_available
        end

        # Set up the ticket information
        flight.set_ticket_id(ticket.id)

      end

      # In creating this JSON, we are going to 
      # be building up the information that we need through flitering out some information
      # about the ticket_class and type that we are working with
      # 
      # Additionally, a trip is now represented by our journey model, which we are saving
      
      journey = Journey.new
      journey.price           = price
      journey.flight_time     = total_duration
      journey.origin_id       = elems.first.origin.id
      journey.destination_id  = elems.last.destination.id
      journey.departure_time  = elems.first.departure_time
      journey.arrival_time    = elems.last.arrival_time
      journey.ticket_class_id = TicketClass.find_by(class_code: ticket_class).id

      journey.save!

      # After creating the journey model, map the flights onto our journey, 
      # setting up a dependancy between them for the journey
       
      val.get_array.each_with_index do |flight, index|

        mapping = JourneyMap.new
        mapping.journey_id = journey.id
        mapping.flight_id = flight.id
        mapping.order_in_journey = index + 1
        mapping.save!

      end

      trip = {
        id: journey.id,
        flightNumber: elems.first.flight_number,
        price: price,
        departureTime: elems.first.departure_time,
        arrivalTime: elems.last.arrival_time,
        seatsAvailable: seats_available,
        flightTime: total_duration,
        origin: elems.first.origin.destination_code,
        destination: elems.last.destination.destination_code,
        isReturnFlight: false,
        ticketClass: ticket_class,
        legs: elems
      }

      journeys.push(trip)

    end

    # Set upt he return stuff
    return_flight_paths.each do |val|

      ticket_class = params['ticketClass']
      ticket_class ||= 'ECO'

      price = 0
      seats_available = val.get_array.first.ticket_availabilities.t_class(ticket_class).smallest_price.seats_available
      total_duration = 0


      # Operates on the individual flights in our flight paths
      val.get_array.each do |flight|
        
        # Set up the flight information
        print("The flight is #{flight.inspect}")
        ticket = flight.ticket_availabilities.t_class(ticket_class).smallest_price
        price += ticket.price
        total_duration += flight.flight_time
        if ticket.seats_available <= seats_available
          seats_available = ticket.seats_available
        end

        # Set up the ticket information
        flight.set_ticket_id(ticket.id)

      end

      # In creating this JSON, we are going to 
      # be building up the information that we need through flitering out some information
      # about the ticket_class and type that we are working with
      # 
      # Additionally, a trip is now represented by our journey model, which we are saving
      
      journey = Journey.new
      journey.price           = price
      journey.flight_time     = total_duration
      journey.origin_id       = elems.first.origin.id
      journey.destination_id  = elems.last.destination.id
      journey.departure_time  = elems.first.departure_time
      journey.arrival_time    = elems.last.arrival_time
      journey.ticket_class_id = TicketClass.find_by(class_code: ticket_class).id

      journey.save!

      # After creating the journey model, map the flights onto our journey, 
      # setting up a dependancy between them for the journey
       
      val.get_array.each_with_index do |flight, index|

        mapping = JourneyMap.new
        mapping.journey_id = journey.id
        mapping.flight_id = flight.id
        mapping.order_in_journey = index + 1
        mapping.save!

      end

      trip = {
        id: journey.id,
        flightNumber: elems.first.flight_number,
        price: price,
        departureTime: elems.first.departure_time,
        arrivalTime: elems.last.arrival_time,
        seatsAvailable: seats_available,
        flightTime: total_duration,
        origin: elems.first.origin.destination_code,
        destination: elems.last.destination.destination_code,
        isReturnFlight: true,
        ticketClass: ticket_class,
        legs: elems
      }

      journeys.push(trip)

    end

    render json: journeys

    end

    def promo_flights_load

      flight_number = params['flightNumberPromo']
      date = DateTime.parse(params['departDatePromo']).strftime('%Y-%m-%d %H:%M:%S UTC')
      max_date = DateTime.parse(params['maxDepartDatePromo']).strftime('%Y-%m-%d %H:%M:%S UTC')

      render json: Flight.where('flight_number = ? and departure_time >= ? and departure_time <= ?', 
        flight_number, date, max_date), status: 201


    end


  def show
    render json: Flight.find(params[:id])
  end

  # Action that maps to a purchase!
  # We will expect
    # some kind of user id
    # flight/s :: ids
    # ticket class that the purchase related to
    # ticket_type that the purchase relates to -- NOTE THAT WE ARE IGNORING THIS FOR NOW
  # We require these in order to decrement the availability associated with that flight
  def purchase

    print("Purchase Call Params!: " + params )

  end

end
