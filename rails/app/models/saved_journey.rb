class SavedJourney < ActiveRecord::Base
  belongs_to :user
  belongs_to :journey
  belongs_to :save_identifier
end
