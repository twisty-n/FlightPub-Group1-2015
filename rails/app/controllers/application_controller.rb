class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  check_authorization

  #This should provide us with our current user
  include SessionsHelper

  # Catch all CanCan errors and alert the user of the exception
  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end
#new commat
  def user_id
  	return current_user
  end


end
