class SavedJourney < ActiveRecord::Base

    # validates_uniqueness_of :user_id, :scope => [:journey_id, :save_identifier_id]

  belongs_to :user
  belongs_to :journey
  belongs_to :save_identifier

  scope :purchased, -> { joins(:save_identifier).merge(SaveIdentifier.purchased) }



end
