class ApiKey < ActiveRecord::Base

  # Set up access and action based rules for this class
  validates :scope, inclusion: { in: %w( session api ) }
  before_create :generate_access_token, :set_expiry_date
  belongs_to :user

  scope :session, -> { where(scope: 'session') }
  scope :api, -> { where(scope: 'api')}
  scope :active, -> { where('expired_at >= ?', Time.now) }

  private

=begin
     Sets the expiry date of the access token based on the type
     of access token that has been requested
     If its requested as a session access token, it is 30 days, else, for a
     for a normal access token, its 4 hours
=end
  def set_expiry_date
    self.expired_at = 0

    if self.scope == 'session'
      self.expired_at = 4.hours.from_now
    else
      self.expired_at = 30.days.from_now
    end

  end
  
=begin
     Generates an access token to be used as a key
=end
  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
end
