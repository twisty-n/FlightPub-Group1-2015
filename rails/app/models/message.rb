class Message < ActiveRecord::Base
  
  belongs_to :user_conversation
  belongs_to :user

  def sender
  	return @user_id
  end

end
