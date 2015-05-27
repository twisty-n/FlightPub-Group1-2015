class PurchaseMailer < ApplicationMailer
    
    default from: 'flightpub@gmail.com'

    # Defines an email to be sent to a users email address when they register for a flightpub account
    def purchase_flight_email(dep_journey_id, ret_journey_id, user_id)

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

        if ret_journey != nil
            ret_journey.journey_maps.each do |map|
                @ret_flights.push( {
                        'order' => map.order_in_journey,
                        'flight'=> map.flight
                    } )
            end
        end

        mail(to: @user.email, subject: 'Your flight Itinerary')
        print "Yay we purchased a flight"

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

        if ret_tickets != nil
            ret_tickets.each do |ticket_id|
                tick = TicketAvailability.find_by(id: ticket_id)
                @ret_tickets.push( tick )
                @sum_ret += tick.price
            end
        end
        mail(to: @user.email, subject: 'Invoice details for your recent purchase')
    end
end
