class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  #check_authorization



  # Define a way for CanCan to recover from bad access. This will allow
  # a way to recover from API stuff
  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug('Attempt to access unauthorized resoruce')
    format.json { render :json=> exception.to_json, :status => :forbidden }
  end


  #This should provide us with our current user
  #include SessionsHelper

  # Define information to be used by the API functions
  protected

  def unimplemented_status
    render :nothing => true, :status => :not_implemented
  end

  # Returns the active user associated with the access token if available
  def current_user
    api_key = ApiKey.active.where(access_token: token).first
    if api_key
      return api_key.user
    else
      return nil
    end
  end

  #Render a 401 status code if the current user has no authorization
  def ensure_authenticated_user
    head :unauthorized unless current_user
  end

  #Returns the active user associated with the current access token if available
  def token
    bearer = request.headers["HTTP_AUTHORIZATION"]
    bearer ||= request.headers["rack.session"].try(:[], 'Authorization')
    if bearer.present?
      bearer.split.last
    else
      nil
    end
  end

  # Render a 401 status code unless that user has an administration role
  def ensure_admin_user
    head :unauthorized unless current_user.is? :admin
  end



end
