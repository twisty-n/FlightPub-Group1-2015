class PurchaseMailer < ApplicationMailer
    
    default from: 'flightpub@gmail.com'

    # Defines an email to be sent to a users email address when they register for a flightpub account
    def purchase_flight_email(dep_journey_id, ret_journey_id, user_id)

        # TODO: perhaps seperate dep and return flights into two seperate emails
        # This will make the google now integration work far better as well

        @user = User.find_by(id: user_id)

        @dep_flights = Array.new
        @ret_flights = Array.new

        dep_journey = Journey.find_by(id: dep_journey_id)
        ret_journey = Journey.find_by(id: ret_journey_id)

        dep_journey.journey_maps.each do |map|
            @dep_flights.push( {
                    'order' => map.order_in_journey,
                    'flight' => map.flight
                } )
        end

        @g_now_string = print generate_google_now_json(dep_journey, @user)

        if ! ret_journey.blank?
            ret_journey.journey_maps.each do |map|
                @ret_flights.push( {
                        'order' => map.order_in_journey,
                        'flight'=> map.flight
                    } )
            end
        end

        mail(to: @user.email, subject: 'Your flight Itinerary')
        #print "Yay we purchased a flight"

    end

    def generate_invoice(dep_tickets, ret_tickets, num_to_get, user_id)

        @user = User.find_by(id: user_id)

        @dep_tickets = Array.new
        @ret_tickets = Array.new

        @num_to_get = num_to_get

        @sum_dep = 0
        @sum_ret = 0

        dep_tickets.each do |ticket_id|
            tick = TicketAvailability.find_by(id: ticket_id)
            @dep_tickets.push( tick )
            @sum_dep += tick.price
        end

        if ! ret_tickets.blank?
            ret_tickets.each do |ticket_id|
                tick = TicketAvailability.find_by(id: ticket_id)
                @ret_tickets.push( tick )
                @sum_ret += tick.price
            end
        end
        mail(to: @user.email, subject: 'Invoice details for your recent purchase')
    end

    private

    def generate_google_now_json(journey, user) 

        print "Generating Google Now flight reservation JSON schema\n"
        print journey.inspect
        script_start_tag = "<script type=\"application/ld+json\">"
        script_end_tag = "</script>"
        journey_json = ""
        list_op = "["
        list_close = "]"

        # Code for generating the random string we are going to sue for the boking reservation number
        o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
        reservation_number = (0...50).map { o[rand(o.length)] }.join

        # start to build the string
        journey_json += script_start_tag
        journey_json += list_op

        journey.journey_maps.each_with_index do | the_journey, index |

            append_comma = ( index == journey.journey_maps.size - 1 )
            flight = the_journey.flight

            append_string = '{
                                "@context": "http://schema.org",
                                "@type": "FlightReservation",
                                "reservationNumber": "#{reservation_number}",
                                "reservationStatus": "http://schema.org/Confirmed",
                                "underName": {
                                  "@type": "Person",
                                  "name": "#{user.first_name} #{user.last_name}"
                                },
                                "reservationFor": {
                                  "@type": "Flight",
                                  "flightNumber": "#{flight.flight_number}",
                                  "airline": {
                                    "@type": "Airline",
                                    "name": "#{flight.airline.airline_name}",
                                    "iataCode": "#{flight.airline.airline_code}"
                                  },
                                  "departureAirport": {
                                    "@type": "Airport",
                                    "name": "#{flight.origin.airport}",
                                    "iataCode": "#{flight.origin.airport_code}""
                                  },
                                  "departureTime": "#{flight.departure_time}",
                                  "arrivalAirport": {
                                    "@type": "Airport",
                                    "name": "#{flight.destination.airport}",
                                    "iataCode": "#{flight.destination.airport_code}"
                                  },
                                  "arrivalTime": "#{flight.arrival_time}"
                                }
                              }'
            if append_comma
                append_string = append_string + ","

            journey_json = journey_json + append_string

            end
        end

        journey_json += list_close
        journey_json += script_end_tag

        return journey_json

    end
end