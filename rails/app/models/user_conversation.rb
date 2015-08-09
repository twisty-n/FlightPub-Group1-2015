class UserConversation < ActiveRecord::Base

	validates_uniqueness_of :participant_1_id, :scope => :participant_2_id
	validates_uniqueness_of :participant_2_id, :scope => :participant_1_id


    belongs_to :participant_1, class_name: "User"
	belongs_to :participant_2, class_name: "User"

	scope :contains_user, -> (user_id) { where("participant_1_id = ? OR participant_2_id = ?", user_id, user_id) }

	# post a message to this conversation. 
	# The expected type is Message
	def post_message(message)

		# So for this. We need to increment the message count
		# The message should already contain all of the needed details
		# We just need to populate the message_number
		# 
		self.message_count = self.message_count + 1
		self.save!

		print(" message count for convo #{self.message_count}")
		
		message.message_number = self.message_count

		print(" Message number in convo: #{message.message_number}")

		message.save!

		# For expanded functionality, we will send a push notification here when we 
		# have the technology
		print "sent notification to user #{message.user_id}"

	end
end
