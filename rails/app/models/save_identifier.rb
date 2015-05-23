class SaveIdentifier < ActiveRecord::Base

    has_many :saved_journeys

    scope :common,      -> { where('s_type = ?', :common_flight)}
    scope :saved,       -> { where('s_type = ?', :saved_flight)}
    scope :purchased,   -> { where('s_type = ?', :purchased_flight)}

end
