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

	# Hook to delete a conversation for a certain user. The concersation will still be visible to the
	# user that did not delete it. This will essentially be a soft delete. If the other user wishes to 
	# continue a conversation. it will be recreated on the deleting users phone
	# 
	# Need to come back to the semantics on this. So ill leave it unimplemented for now
	# 
	def delete_conversation

	end

	# Hook to check if a conversation has new messages, based on a message count
	# and conversation id
	# If it does, a JSON payload will be returned with the messages
	# if it doesn't we will still return success, but with a status that says no
	# new messages were available
	# params
	# 	conversationId: 	the Id of the conversation that we are checking for updates
	# 	clientMessageCount: The number of messages that the client has recorded as 
	# 						as being a part of the conversation	
	# 	
	def check_update

		conversation_id = params[:conversationId]
		client_message_count = params[:clientMessageCount]

		conversation = UserConversation.find_by(id: conversation_id)
		if client_message_count.to_i < conversation.message_count

			# the client requires updates
			render json: conversation
							.messages
							.messages_higher_than(client_message_count), status: 201
			
		else

			# We will return a good code, cause the operation didn't fail,
			# but there was nothing to report
			render json: { status: "UpToDate" }, status: 201

		end

	end


end
