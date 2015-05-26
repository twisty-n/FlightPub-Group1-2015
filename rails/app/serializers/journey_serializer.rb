class JourneySerializer < ActiveModel::Serializer
=begin

journeys":[
{"id":23,"created_at":"2015-05-26T03:17:10.000Z","updated_at":"2015-05-26T03:17:10.000Z",
	"price":1102,"flight_time":1340,"origin_id":996148811,"destination_id":792891925,"departure_time":"2015-03-28T15:30:00.000Z",
	"arrival_time":"2015-03-30T10:45:00.000Z","ticket_class_id":422391454},
{"id":45,"created_at":"2015-05-26T03:19:05.000Z","updated_at":"2015-05-26T03:19:05.000Z",
"price":1644,"flight_time":1010,"origin_id":748732216,"destination_id":814406766,"departure_time":"2015-05-04T08:05:00.000Z",
"arrival_time":"2015-05-23T06:30:00.000Z","ticket_class_id":422391454}

=end
  attributes :id, :price, :flight_time, :origin, :destination, :departure_time, :arrival_time, :flights
  #has_many :flights, through: :journey_maps

  def flights
    object.journey_maps.each do | journey_map |
      JourneyMapSerializer.new(journey_map)
    end
  end
  
  def destination
  	object.destination.airport
  end

  def origin
  	object.origin.airport
  end
  
end