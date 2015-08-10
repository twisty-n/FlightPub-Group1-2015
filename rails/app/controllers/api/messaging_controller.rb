class Api::MessagingController < ApplicationController

=begin

	Responsible for handling messages and conversations between users
	This includes the rub_shoulders functionality and any other additional 
	messaging functionality

=end

	
	# Hook to send a message to a user
	# params
	# 	message: 			JSON object encapsulating a message
	  	# Create a new message object from a json Object
  	# 	message: 			JSON object encapsulating a message
	# 		JSON message => {
	# 			"userConversationId" 	=> " < the id > ",
	# 			"sendingUserId"			=> " < the id > ",
	# 			"content" 				=> " < the content > "
	# 		}
	def post_message

		print "#{params[:message]}"

		message = params[:message]					# This will be a JSON object
		UserConversation.find_by(id: message[:userConversationId])
				.post_message(
					Message.from_json(message)
				)
		render json: {
				'status' => 'Operation Success!'
				},  status: 201

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
