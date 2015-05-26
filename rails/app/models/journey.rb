class Journey < ActiveRecord::Base

  belongs_to :user
  belongs_to :save_identifier

  belongs_to :destination, class_name: "Destination"
	belongs_to :origin, class_name: "Destination"

  has_many :flights
  has_many :journey_maps
  has_many :flights, :through => :journey_maps
end
