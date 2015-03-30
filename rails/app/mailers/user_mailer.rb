class UserMailer < ApplicationMailer
	
	default from: 'noreply@flightpub.com'

	# Defines an email to be sent to a users email address when they register for a flightpub account
	def welcome_email(user)
		@user = user
		@url = Rails.application.config.base_url + 'login'
		mail(to: @user.email, subject:"Welcome to FlightPub!")
		#logger.debug 'Sending welcome email to ' + @user.fName + @user.lName
	end

	# Defines an email to be sent when a user deletes their account
	def delete_email(user)
		@user = user
		@url = Rails.application.config.base_url + 'login'
		mail(to: @user.email, subject:"Sorry to see you go :(")
	end

end
