class Journey < ActiveRecord::Base

    # We do not record the number of seats available for a journey
    # because this value will change over the course of the journeys
    # duration

  belongs_to :user
  belongs_to :save_identifier
end
