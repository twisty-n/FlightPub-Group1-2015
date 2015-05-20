# This class represents a possible flight path.
# It is produced by the search algorithm, and then passed to
# the serializer, where it will be converted into json output.

class FlightPath

# ------------------------------- Class Variables --------------------------------- #

id = String.new
origin = String.new
destination = String.new
no_of_connecting_flights = Array.new


# ------------------------------- Getters and Setters --------------------------------- #

attr_accessor :id, :origin, :destination, :no_of_connecting_flights

end