class Api::AirlinesController < ApplicationController

    # Returns the terms and conditions URL for an airline
    def terms
        airline = params[:airline_id]
        airline_m = Airline.find_by(id: airline)

        if airline_m != nil
            render json: { 'url' => airline_m.terms_url }, status: 200
        else
            render json: { 'url' => 'An unknown error has occured' }, status: 422
        end
    end

end
