module SessionsHelper
#
#Logs  in the given user
	def log_in(user)
		session[:user_id] = user.userID
	end

	def current_user
		@current_user ||= User.find_by(userID: session[:user_id])
	end

	def logged_in?
		!current_user.nil?
	end

	def log_out
		session.delete(:user_id)
		@current_user = nil
	end


end
