class PurchaseMailer < ApplicationMailer
    
    default from: 'noreply@flightpub.com'

    # Defines an email to be sent to a users email address when they register for a flightpub account
    def purchase_flight_email(dep_journey, ret_journey, user_id)

        @user = User.find_by(id: user_id)

        @dep_flights = Array.new
        @ret_flights = Array.new

        dep_journey = Journey.find_by(id: dep_journey)
        ret_journey = Journey.find_by(id: ret_journey)

        dep_journey.journey_maps.each do |map|
            @dep_flights.push( {
                    'order' => map.order_in_journey,
                    'flight' => map.flight
                } )
        end

        ret_journey.journey_maps.each do |map|
            @ret_flights.push( {
                    'order' => map.order_in_journey,
                    'flight'=> map.flight
                } )
        end

        mail(to: @user.email, subject: 'Your flight Itinerary')
        print "Yay we purchased a flight"

    end

    def generate_invoice(dep_tickets, ret_tickets, num_to_get, user_id)

        print 'Yay! we have an invoice!'

    end
end
