class UserConversation < ActiveRecord::Base

	validates_uniqueness_of :participant_1_id, :scope => :participant_2_id
	validates_uniqueness_of :participant_2_id, :scope => :participant_1_id


    belongs_to :participant_1, class_name: "User"
	belongs_to :participant_2, class_name: "User"

	scope :contains_user, -> (user_id) { where("participant_1_id = ? OR participant_2_id = ?", user_id, user_id) }
end
