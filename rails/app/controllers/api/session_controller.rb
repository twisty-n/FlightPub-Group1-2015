class Api::SessionController < ApplicationController

        skip_authorization_check :only => [:create]

    # Creates a new user session

    def create
        user = User.find_by email: params[:email]
        if user && user.authenticate(params[:password])
            reactivate(user)
            render json: user.session_api_key, status: 201
        else
            render json: {
                "error" => "Unauthorized"
                }, status: 401
        end
    end

    private 

    def login_params
         params.permit(:email, :password)
    end

            # Reactivates a user account
    def reactivate(user)
        if !user.account_active?
            user.reactivate!
        end
    end



end
