class Api::UsersController < ApplicationController

	# We do this to avoid the cancan stuff for now
	# TODO: Adjust the CanCan stuff so that it works correctly :)
	skip_authorize_resource :only => [:index, :show]
  	skip_authorization_check

  	#Roll our own authorization in this case, things my be ongoing
  	before_filter :ensure_authenticated_user, only: [:index]

  	# Renders all of the users
	def  index
		render json: User.all
	end


	# Reactivates a user account
	def reactivate
		if !@user.account_active?
			@user.reactivate!
		end
		render json: @user
	end

	# Returns the details of the user
	def show
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

		if @user.update(user_params)
			render json: user, status: 200
		else
			render json: { errors: user.errors.messages }, status: 422
		end

	end

	# Deactivates a user accountl
	def destroy
		@user = User.find(params[:id])
		@user.soft_delete!
		UserMailer.delete_email(@user).deliver_now
		render json: payload, status: 200
	end

	private

	# Define the permitted user paramaters. Anything listed will be allowed as a provided paramater
	# note that the password defintions are automatically inluded in this list
	def user_params
		params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :info_string, :email, :role, :account_status)
	end

end
