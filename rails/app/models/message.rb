class Message < ActiveRecord::Base
  
  belongs_to :user_conversation
  belongs_to :user

  scope :messages_higher_than, -> (message_count) { where("message_number > ?", message_count) }

  def sender
  	return @user_id
  end

  	# Create a new message object from a json Object
  	# 	message: 			JSON object encapsulating a message
	# 		JSON message => {
	# 			"userConversationId" 	=> " < the id > ",
	# 			"sendingUserId"			=> " < the id > ",
	# 			"content" 				=> " < the content > "
	# 		}
  def self.from_json(json_message)

  	msg = Message.new
  	msg.content = json_message[:content]
  	msg.user_id = json_message[:sendingUserId]
  	msg.user_conversation_id = json_message[:userConversationId]

  	return msg

  end

end