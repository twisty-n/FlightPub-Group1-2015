class User < ActiveRecord::Base

  has_many :api_keys
  has_many :saved_journeys
  has_many :journeys, :through => :saved_journeys
  has_many :conversations

	validates :first_name, 	length: {maximum: 40}
	validates :last_name,   length: {maximum: 40}
	validates :address, length: {maximum: 200}
	validates :email, confirmation: true, presence: true, uniqueness: true

	scope :on_journey, ->(journey_id) { joins(:saved_journeys).where("journey_id = ?", journey_id).merge(SavedJourney.purchased) }

	# This will automagically ensure that the user has a password and that the
	# password is valid
	has_secure_password

	# Methods that are set under_before create are done before the user model is saved
	# to the database
	before_create :set_roles

	# Define our CanCan roles. We dont do it in the DB as we only have two roles
	Roles = [ :admin, :default ]

=begin
	def as_json(options={})
		{
			:id => self.id,
			:first_name => self.firstName,
			:last_name => self.lastName,
			:email => self.email,
			:address => self.address,
			:account_status => self.account_status,
			:role => self.role,
			:include => {
				:journeys => {
					:only => :price, :flight_time
				}
			}
		}
	end
=end
    def session_api_key
      api_keys.active.session.first_or_create
    end
        
	def soft_delete!
		self.account_status = 'inactive'
		self.save
	end

	def reactivate!
		self.account_status = 'active'
		self.save
	end

	def account_active?
		return self.account_status == 'active'
	end

	def is?(requested_role)
		self.role == requested_role.to_s
	end

	def user_id
		return @id
	end

	# Rub shoulders with another User. This will automatically generate
	# a conversation and content for the message an launch the sending process
	# 
	# This method returns true if the bug shoulders succeeded, or false if a
	# conversation already existed.
	# 
	# Semnatically, rubbing shoulders is the way to initiate a conversation with another user
	def rub_shoulders(initiate_user_id)

		# Check if a conversation exists
		if UserConversation.does_exist?(initiate_user_id, self.id)
			print "#{initiate_user_id} tried to rub shoudlers with #{self.id} but a conversation already existed"
			return false
		else

			# Create new conversation
			convo.participant_1_id = initiate_user_id
			convo.participant_2_id = self.id
			convo.message_count = 0
			convo.save!

			# Create new message
			initiate_user = User.find_by(id: :initiate_user_id)
			message = Message.new			
			message.user_conversation_id = convo.id
			message.user_id = initiate_user_id

			# For now we will use email but later we will change it to u
			# se first name last name
			# TODO!
			message.content = 
			" Hi! #{initiate_user.email} would like to rub shoulders with you! Reply to start your mile high adventure."
			# 	post to conversation
			
			convo.post_message(message)
			return true

		end
		
		# Else
		

	end

	# Create or retrieve a user using their google information
	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
			user.uid = auth.uid
			user.first_name = auth.info.name.split(" ")[0]
			user.last_name = auth.info.name.split(" ")[1]
			user.email = auth.info.email
			user.oauth_token = auth.credentials.token
			user.oauth_expires_at = Time.at(auth.credentials.expires_at)
			user.password = "password"
			user.save!
		end
	end

	private

		# Sets up some base roles and status' while creating the user
		def set_roles
			self.role = "default"
			self.account_status = "active"
		end

end
