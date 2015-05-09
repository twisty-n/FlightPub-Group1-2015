class SessionsController < ApplicationController

  skip_authorization_check :only => [:new, :create, :destroy, :create_oa, :auth_params]
  
  def new
  end

  def create
    unimplemented_status and return
  	user = User.find_by(email: params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
  		#Log the user in
  		log_in user
  		redirect_to user
  	else
  		flash.now[:danger] = "Unable to process login, invalid details"
  		render 'new'
  	end
  end

  def destroy
    unimplemented_status and return
  	log_out if logged_in?
  	redirect_to root_url
  end

  def create_oa
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end

  def auth_params
    params.require(:user).permit(:first_name, :last_name, :password, :info_string, :email)
  end

end
