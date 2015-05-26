class PurchaseMailer < ApplicationMailer
    
    default from: 'noreply@flightpub.com'

    # Defines an email to be sent to a users email address when they register for a flightpub account
    def purchase_flight_email()

        print "Yay we purchased a flight"

    end

end
