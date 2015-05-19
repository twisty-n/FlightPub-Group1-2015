class Flight < ActiveRecord::Base

    belongs_to :airline

    has_many :saved_flights
    has_many :users, :through => :saved_flights

end
