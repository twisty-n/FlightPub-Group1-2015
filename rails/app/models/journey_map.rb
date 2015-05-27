class JourneyMap < ActiveRecord::Base
  belongs_to :journey
  belongs_to :flight

  def as_json

    {
        order_in_flight: self.order_in_journey,
        flight: self.flight
    }

  end

end
