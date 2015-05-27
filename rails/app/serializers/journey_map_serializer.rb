class JourneyMapSerializer < ActiveModel::Serializer

  attributes :flight_info, :order_in_journey
  
  def flight_info

    object.flight.as_json

  end
  
end