class Api::UsersController < ApplicationController

	# We do this to avoid the cancan stuff for now
	# TODO: Adjust the CanCan stuff so that it works correctly :)
	skip_authorize_resource :only => [:index, :show]
  	skip_authorization_check

  	#Roll our own authorization in this case, things my be ongoing
  	# before_filter :ensure_authenticated_user, only: [:index]

  	# Renders all of the users
	def  index
		render json: User.all
	end

    # Authorizes a user as an administrator
    def admin_auth
        user = User.find_by(id: params[:user_id])
        if ! user
        	render json: {
                "error" => "Unauthorized"
                }, status: 401
                return
        end 
        if user.is? :admin
            render json: {}, status: 201
        else
            render json: {
                "error" => "Unauthorized"
                }, status: 401
        end 
    end

	# Returns the details of the user
	def show
		#reactivate(params[:id])
		#print("we are here now")
		render json: User.find(params[:id])
	end

	# Creates a new user
	def create
		@user = User.create(user_params)

		# If the user has been saved, send a welcome email
		if not @user.new_record?
			# TODO: set up process queue to send emails outside of the req cycle
			# for now, we will do it inline
			UserMailer.welcome_email(@user).deliver_now
			render json: @user.session_api_key, status: 201
		else
			render json: { errors: @user.errors.messages }, status: 422
		end
	end


	# Updates a users details
	def update

		@user = User.find(params[:id])
		# @user.assign_attributes(user_params)

		# Only try to save attributes that have been updated
		params[:user].delete(:password) if params[:user][:password].blank?
		
		if @user.update_attributes(user_params)

				render json: @user, status: 200

		else
			print("error updating user #{@user.errors.messages.inspect}")
			render json: { errors: @user.errors.messages.inspect }, status: 422
		end

	end

	# Deactivates a user accountl
	def destroy
		@user = User.find(params[:id])
		@user.soft_delete!
		UserMailer.delete_email(@user).deliver_now
		render json: {}, status: 200
	end

	# Will return a listing of all the users that are aboard some flight
	# This listing will not include the user that requested the listing
	# 
	# param1  journeyId: 	the journey that the user is requesting the information for
	# params2 userId:  		the id of the user that requested the flight
	#
	def get_users_on_flight_reject_requester

		# Then query saved journeys using the 'purchased_flight' identifier
		# for a list of the the other user id's who are on the flight
		# 
		# Remove the queryer from the list and remove sensetive information
		# 
		# Done. Return our model list

		journey_id = params["journeyId"]
		user_id = params["userId"]

		user_list = User.on_journey(journey_id).reject{ |s| s.id == user_id }

		render json: user_list.as_json(only: [:id, :first_name, :last_name, :email]), status: 200

	end

	private

	# Define the permitted user paramaters. Anything listed will be allowed as a provided paramater
	# note that the password defintions are automatically inluded in this list
	def user_params
		params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :address, :email, :role, :account_status)
	end

end
