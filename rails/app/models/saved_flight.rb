class SavedFlight < ActiveRecord::Base

    belongs_to :user
    belongs_to :flight
    belongs_to :save_identifier

end
