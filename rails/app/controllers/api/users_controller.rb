class Api::UsersController < ApplicationController


	skip_authorize_resource :only => [:index, :show]
  skip_authorization_check

	def  index
		render json: User.all
	end

	def show
		if !@user.account_active?
			@user.reactivate!
		end
		render json: @user
	end

	def new
		#All this does is render the editing form
		@user = User.new
	end
	# A user can edit their own stuff, or an admin can edit anything
	def edit
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)

		if @user.save
			log_in @user
			flash[:success] = "Welcome to the test application!"

			# TODO: set up process queue to send emails outside of the req cycle
			# for now, we will do it inline
			UserMailer.welcome_email(@user).deliver_now

			redirect_to @user #tells the browser to issue another request
		else
			render 'new' #passes the user object back into the new method to be used
		end
	end

	def update
		@user = User.find(params[:id])

		if @user.update(user_params)
			redirect_to @user
		else
			render 'edit'
		end

	end

	def destroy
		@user = User.find(params[:id])
		@user.soft_delete!
		UserMailer.delete_email(@user).deliver_now
		#@user.destroy
		if @user.is? 'admin'
			redirect_to users_path
		else
			redirect_to logout_path
		end
	end

	def reactivate
		@user.reactivate!
		redirect_to user_path
	end
	private

	def user_params
		params.require(:user).permit(:fName, :lName, :password, :infoString, :email, :role)
	end

end
