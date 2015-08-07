class Message < ActiveRecord::Base
  
  belongs_to :user_conversation
  belongs_to :user

  scope :messages_higher_than, -> (message_count) { where("message_number > ?", message_count) }

  def sender
  	return @user_id
  end

end
