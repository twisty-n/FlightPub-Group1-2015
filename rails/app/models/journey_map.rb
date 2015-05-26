class JourneyMap < ActiveRecord::Base
  belongs_to :journey
  belongs_to :flight
end
