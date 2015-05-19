require 'active_record/fixtures'

namespace :fix_ids do

    desc "Make all of the ID's of the modified supplied database accurate"
    task :fix_all => :environment do
        Rake::Task["fix_ids:fix_destination"].invoke
         Rake::Task["fix_ids:fix_airline"].invoke
    end

    desc "Map desitnation country_id to the correct country"
    task :fix_destination => :environment do
        file = File.join(Rails.root, 'test', 'linker', 'destinations_unnormed.yml')
        unnormed = YAML.load_file(file).values

        Destination.all.each do |dest|

            unnormed_destination = unnormed.select{|d| d["destination_code"] == dest.destination_code}
            #print(unnormed_destination)

            country = Country.find_by(country_code_3: unnormed_destination[0]["country_code_3"])
            #print(country.inspect)

            country_id = country.id
            dest.country_id = country_id
            dest.save!

        end 

    end

    desc "Map Airline country ID to the correct Country"
    task :fix_airline => :environment do
        file = File.join(Rails.root, 'test', 'linker', 'airlines_unnormed.yml')
        unnormed = YAML.load_file(file).values

        Airline.all.each do |airline|

            unnormed_airline = unnormed.select{|d| d["AirlineCode"] == airline.airline_code}
            print(unnormed_airline)

            country = Country.find_by(country_code_3: unnormed_airline[0]["CountryCode3"])
            #print(country.inspect)

            country_id = country.id
            airline.country_id = country_id
            airline.save!

        end 

    end

    desc "Magic the flights"
    task :fix_flights => :environment do
=begin
        Airline.all.each do |airline|

            unnormed_airline = unnormed.select{|d| d["AirlineCode"] == airline.airline_code}
            print(unnormed_airline)

            country = Country.find_by(country_code_3: unnormed_airline[0]["CountryCode3"])
            #print(country.inspect)

            country_id = country.id
            airline.country_id = country_id
            airline.save!
=end
        
        Flight.destroy_all
        TicketAvailability.destroy_all

        FlightsRaw.all.each do |raw_flight|

            # Check for composite flights based on the stopover code
            # print(raw_flight.inspect)
            if raw_flight.StopOverCode != nil

                # Then we have a composite flight, so deal with it
            else

                # Else its a single flight

                # Create our new normal flight and populate its fields
                flight = Flight.new
                flight.flight_number = raw_flight.FlightNumber
                flight.departure_time = raw_flight.DepartureTime.to_s
                flight.arrival_time = raw_flight.ArrivalTime.to_s
                flight.flight_time = raw_flight.Duration
                flight.is_composite_flight = false
                flight.destination_id = Destination.find_by(destination_code: raw_flight.DestinationCode)
                flight.origin_id = Destination.find_by(destination_code: raw_flight.DepartureCode)
                flight.airlines_id = Airline.find_by(airline_code: raw_flight.AirlineCode)

                flight.save!

                # Now we create all of our ticket availabilities
                Availability.where("FlightNumber = :f_no AND DepartureTime = :d_time", {
                    f_no: raw_flight.FlightNumber, d_time: raw_flight.DepartureTime
                    }).find_each do |availability|

                    ticket_availability = TicketAvailability.new
                    ticket_availability.flight_id = flight.id
                    ticket_availability.ticket_type_id = TicketType.find_by(ticket_code: availability.TicketCode).id
                    ticket_availability.ticket_class_id = TicketClass.find_by(class_code: availability.ClassCode).id
                    ticket_availability.seats_available = availability.NumberAvailableSeatsLeg1
                    begin
                        ticket_availability.price = Price.where("FlightNumber = :f_no 
                            AND StartDate <= :av_date 
                            AND EndDate >= :av_date 
                            AND TicketCode = :tic_code
                            AND ClassCode = :c_code", {
                                f_no: flight.flight_number, 
                                av_date: availability.DepartureTime,
                                tic_code: availability.TicketCode,
                                c_code: availability.ClassCode
                            }).first.Price
                    rescue NoMethodError
                        ticket_availability.price = -1
                    end
                    ticket_availability.save!

                end

            end

            



        end 

    end

end
