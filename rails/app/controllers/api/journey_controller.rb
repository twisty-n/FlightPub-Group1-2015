class Api::JourneyController < ApplicationController

=begin
    This controller will be used to manage the saving and purchasing of journeys
    Remember that a journey is a group of flights

=end

    def save
=begin
        # Called to save a journey via a common flight or standard
        # save. A saved journey is mapped to a user account
        # 
        # Expected params

        {
          'journey_id':  
          'user_id': 
          'save_type': 'saved_flight' || 'common_flight' || 'purchased_flight'
          'account_type': 'regular' || ??
        }

=end
        journey = build_journey(params['user_id'], params['journey_id'],params['save_type'], params['account_type'])
        success = journey.save

        if success
            render json: {
                    }, status: 201
        else
             render json: {
                    'status_message' => 'Unable to save the same flight multiple times'
                    }, status: 422
        end
    end

    def purchase
=begin
        # Called to purchase a journey
        # Purchasing a flight will map the flight to the users account
        # It will also adjust the availabilities for each of flights that make up a journey
        
        # The expected params are
        {
            'tickets_to_purchase':
            'return_journey_id':        OPTIONAL
            'departure_journey_id':
            'user_id': 
            'departure_tickets':
            'returnTickets':            OPTIONAL
            'save_type': 
            'account_type':
        }
=end
        print(params)
        
        # Steps involved in a purchase
        # 1. 'Purchase' all of the departure tickets
        dep_purchase_status = purchase_tickets(params['user_id'], 
            params['departure_tickets'], 
            params['tickets_to_purchase'])

        if dep_purchase_status != PurchasingStatus::TRANSACTION_COMPLETE
            # Look up which error to return
            case dep_purchase_status
            when PurchasingStatus::DUPLICATE_PURCHASE
                render json: {'errorCode' => 'duplicate_purchase'}, status: 422
                return
            when PurchasingStatus::NO_SEATS_AVAILABLE
                render json: {'errorCode' => 'no_seats_available'}, status: 422
                return
            when PurchasingStatus::INSUFFICIENT_NUMBER_OF_SEATS
                render json: {'errorCode' => 'not_enough_seats'}, status: 422
                return
            end
        end

        # 2. Set up the departure journey
        # Implicit else
        departure_journey = build_journey(
            params['user_id'],
            params['departure_journey_id'],
            params['save_type'],
            params['account_type']
        ) 

        if ! departure_journey.save
            # Return error json!
            render json: {'errorCode' => 'internal_error'}, status: 422
            return
        end
        
        if ! params['return_journey_id'].blank?
            # 3. IF there is a return journey
            #   3-1. Set up the return journey
            #   3-2. 'Purchase all of the return tickets'
            ret_purchase_status = purchase_tickets(params['user_id'], 
            params['return_tickets'], 
            params['tickets_to_purchase'])
            if ret_purchase_status != PurchasingStatus::TRANSACTION_COMPLETE
                 # Look up which error to return
                case ret_purchase_status
                when PurchasingStatus::DUPLICATE_PURCHASE
                    render json: {'errorCode' => 'duplicate_purchase'}, status: 422
                    return
                when PurchasingStatus::NO_SEATS_AVAILABLE
                    render json: {'errorCode' => 'no_seats_available'}, status: 422
                    return
                when PurchasingStatus::INSUFFICIENT_NUMBER_OF_SEATS
                    render json: {'errorCode' => 'not_enough_seats'}, status: 422
                    return
                end
            end

            # 2. Set up the departure journey
            # Implicit else
            return_journey = build_journey(
                params['user_id'],
                params['return_journey_id'],
                params['save_type'],
                params['account_type']
            )

            if ! return_journey.save
                # Return error json!
                render json: {'errorCode' => 'internal_error'}, status: 422
                return
            end

        end

        # 4. Send an email to the user with their Journey details
        # => We will send two email
        #       One of them, an invoice
        #       For the invoice, we will need the ticket ids
        #       of all of the tickets
        
        PurchaseMailer.generate_invoice(params['departure_tickets'],
                                        params['return_tickets'],
                                        params['tickets_to_purchase'],
                                        params['user_id']
                                        ).deliver_now

        #       The other one, an itanary of the flight 
        #       For the itinary, 
        #       TODO: Fix this
        PurchaseMailer.purchase_flight_email(params['departure_journey_id'],
                                             params['return_journey_id'],
                                             params['user_id']).deliver_now

        render json: {}, status: 201

    end

    def cancel_purchase
=begin

    Cancel a purchase that a user has made
    We will expect the user_id, as well as the journey id

=end
    
    # Step 1: Remove the journey from the users saved journeys
    # Step 2: Remove all of the tickets from ticket purchases: consider doing this as a state instead of deleteion
    # Step 3: Send an email to the user about their refund and all that crap: add in the terms and conditions

    end

    private

    def build_journey(user_id, journey_id, save_type, account_type)
=begin
            Creates a saved journey based on the provided information
            This journey may be saved flight, or a purchase
=end
        s_journ = SavedJourney.new

        s_journ.user_id = user_id
        s_journ.journey_id = journey_id
        s_journ.save_identifier_id = SaveIdentifier.where('s_type = ? AND account_type = ?',
            params['save_type'],
            params['account_type'] ).first.id
        return s_journ
    end

    def purchase_tickets(user_id, ticket_array, number_to_purchase)
=begin
            Purchases a given set of tickets by decrementing the 
            number of seats available for that ticket
=end

        
        #   -- First we need to check that we can buy that number of tickets
        #   -- if not, throw an error
        #   -- Then we check that there isn't a duplicate purchase

        # TODO: Consider locking the rows when we are doing our checks!
        ticket_array.each do |ticket_id|
            ticket = TicketAvailability.find_by(id: ticket_id)
            if ticket.seats_available == 0 
                return PurchasingStatus::NO_SEATS_AVAILABLE 
            end
            if ticket.seats_available < number_to_purchase.to_i 
                return PurchasingStatus::INSUFFICIENT_NUMBER_OF_SEATS 
            end
            if ! PurchasedTicket.where( 'user_id = ? AND ticket_availability_id = ?', user_id, ticket_id ).blank? 
                return PurchasingStatus::DUPLICATE_PURCHASE 
            end
        end

        # 1. Decrement the ticket availabilities by the number of seats purchased
        # Once we have reached this point, we can safely perform the operations
        # 2. Create an entry in the purchased table with the number of seats purchased    
        ticket_array.each do |ticket_id|
            # Update the seats
            ticket = TicketAvailability.find_by(id: ticket_id)
            ticket.seats_available = ticket.seats_available - number_to_purchase.to_i
            ticket.save!
            # Create the purchase
            purchase = PurchasedTicket.new
            purchase.user_id = user_id
            purchase.ticket_availability_id = ticket_id
            purchase.number_purchased = number_to_purchase.to_i
            purchase.save!
        end    
        return PurchasingStatus::TRANSACTION_COMPLETE        
    end

    class PurchasingStatus

        # Error conditions
        NO_SEATS_AVAILABLE=1
        INSUFFICIENT_NUMBER_OF_SEATS=2
        DUPLICATE_PURCHASE=3

        # Success condition
        TRANSACTION_COMPLETE=4
    end

end
