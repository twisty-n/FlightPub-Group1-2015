class Api::MessagingController < ApplicationController

=begin

	Responsible for handling messages and conversations between users
	This includes the rub_shoulders functionality and any other additional 
	messaging functionality

=end

	
	# Hook to send a message to a user
	def post_message

		# Define the accepted params

	end


	# Hook to rub shoulders with another user
	# params
	# 	initiateUserId: the ID of the user that is initiating the rub shoulders evemt
	# 	targetUserId: 	the ID of the user that the initiate wants to rub shoudlers with
	def rub_shoulders
		
		# Set up
		initiate_user_id = params[:initiateUserId]
		target_user_id = params[:targetUserId]
		target_user = User.find_by(id: target_user_id)
		
		# Attempt action
		if target_user.rub_shoulders( initiate_user_id )

			# Rub shoulders succeeded
			render json: {
				'status' => 'Operation Success!'
				},  status: 201
			
		else 

			render json: { errors: "Conversation exist" }, status: 422
		end

	end

	# Hook to delete a conversation
	def delete_conversation

	end


end
