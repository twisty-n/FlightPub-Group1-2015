class Journey < ActiveRecord::Base

  belongs_to :user
  belongs_to :save_identifier

  has_many :flights
  has_many :journey_maps
  has_many :flights, :through => :journey_maps
end
