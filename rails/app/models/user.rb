class User < ActiveRecord::Base

	validates :fName, 	presence: true, length: {maximum: 40}
	validates :lName,   presence: true, length: {maximum: 40}
	validates :infoString, presence: false, length: {maximum: 200}
	validates :email, confirmation: true, presence: true, uniqueness: true

	before_create :set_roles

	Roles = [ :admin, :default ]

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
			user.fName = auth.info.name.split(" ")[0]
			user.lName = auth.info.name.split(" ")[1]
			user.email = auth.info.email
			user.oauth_token = auth.credentials.token
			user.oauth_expires_at = Time.at(auth.credentials.expires_at)
			user.password = "no_pass"
			user.save!
		end
	end

	# Define out private methods for the user class
	private

		# Sets up some base roles and status' while creating the user
		def set_roles
			self.role = "default"
			self.account_status = "active"
		end

	has_secure_password

end
