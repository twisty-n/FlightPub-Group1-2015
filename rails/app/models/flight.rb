class Flight < ActiveRecord::Base

    has_many :saved_flights
    has_many :users, :through => :saved_flights

end
