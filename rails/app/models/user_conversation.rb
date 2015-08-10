class UserConversation < ActiveRecord::Base

	validates_uniqueness_of :participant_1_id, :scope => :participant_2_id
	validates_uniqueness_of :participant_2_id, :scope => :participant_1_id


    belongs_to :participant_1, class_name: "User"
	belongs_to :participant_2, class_name: "User"

	has_many :messages

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

	# Checks for the existance of a conversation with 
	# the listed user id's
	def self.does_exist?(user_id_1, user_id_2)

		results_1 = UserConversation.where("participant_1_id =? AND participant_2_id = ?", user_id_1, user_id_2)
		results_2 = UserConversation.where("participant_2_id =? AND participant_1_id = ?", user_id_1, user_id_2)

		print "#{results_1.inspect}"
		print "#{results_2.inspect}"

		converExists = ! (results_1.empty? and results_2.empty?)

		print "Does the conversation exist: #{converExists}"

		# Check for nil and no records
		return converExists
	end
end
