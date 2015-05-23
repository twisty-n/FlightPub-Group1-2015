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
        
        # TODO some validation

        s_journ = SavedJourney.new

        s_journ.user_id = params['user_id']
        s_journ.journey_id = params['journey_id']
        s_journ.save_identifier_id = SaveIdentifier.where('s_type = ? AND account_type = ?',
            params['save_type'],
            params['account_type'] ).first.id

        if s_journ.save!

            render json: {
                    "status" => "success"
                    }, status: 201
        else
             render json: {
                    "status" => "butts"
                    }, status: 422

        end

    end

    def purchase
        # Called to purchase a journey
        # Purchasing a flight will map the flight to the users account
        # It will also adjust the availabilities for each of flights that make up a journey
    end

    def user_saved_flights
        # View a set of juorneys that are mapped to a user account

    end

end
