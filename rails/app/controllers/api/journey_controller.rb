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
        # Called to purchase a journey
        # Purchasing a flight will map the flight to the users account
        # It will also adjust the availabilities for each of flights that make up a journey

        print(params)
        success = false
        
        if success

            render json: {
                    }, status: 201
        else
             render json: {
                    'status_message' => 'Unable to purchase flight!'
                    }, status: 422

        end


    end

    def user_saved_flights
        # View a set of juorneys that are mapped to a user account

    end

    private

    def build_journey(user_id, journey_id, save_type, account_type)

        # saves a journey based on the informatoin provided in the params

        s_journ = SavedJourney.new

        s_journ.user_id = user_id
        s_journ.journey_id = journey_id
        s_journ.save_identifier_id = SaveIdentifier.where('s_type = ? AND account_type = ?',
            params['save_type'],
            params['account_type'] ).first.id

        return s_journ

    end

end

=begin


begin
  @ticket.transaction do
    @ticket.save!
    @user.save!
  end
  #handle success here
rescue ActiveRecord::RecordInvalid => invalid
   #handle failure here
end

    
=end
