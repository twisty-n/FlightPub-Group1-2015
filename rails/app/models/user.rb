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
