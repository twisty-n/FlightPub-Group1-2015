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

    desc "Fix the magic"
    task :fix_avs => :environment do


        # Iterate over each composite flight

        Flight.where(is_composite_flight: true).each do |c_flight|

            # Look up all the availabilities that relate to this flight
            # Do this based on FlightNumber and departureTime
            # NEeded to adjust the departureTime to have UTC as well
            AvailabilityFix.where("FlightNumber = :f_no AND DepartureTime = :d_time", {
                    f_no: c_flight.flight_number, d_time: c_flight.departure_time
                    }).find_each do |availability|

                print ("Entered availability creation!")

                leg_1_av = TicketAvailability.new
                leg_2_av = TicketAvailability.new

                # Set up flight id's
                leg_1_av.flight_id = c_flight.leg_1_id
                leg_2_av.flight_id = c_flight.leg_2_id

                # Set up ticket type ids
                leg_1_av.ticket_type_id = TicketType.find_by(ticket_code: availability.TicketCode).id
                leg_2_av.ticket_type_id = leg_1_av.ticket_type_id

                # set up ticket class id's
                leg_1_av.ticket_class_id = TicketClass.find_by(class_code: availability.ClassCode).id
                leg_2_av.ticket_class_id = leg_1_av.ticket_class_id

                # Set up number of seats
                leg_1_av.seats_available = availability.NumberAvailableSeatsLeg1
                leg_2_av.seats_available = availability.NumberAvailableSeatsLeg2

                # Set up price
                price_var = PriceFix.where("FlightNumber = :f_no 
                            AND StartDate <= :av_date 
                            AND EndDate >= :av_date 
                            AND TicketCode = :tic_code
                            AND ClassCode = :c_code", {
                                f_no: c_flight.flight_number, 
                                av_date: availability.DepartureTime,
                                tic_code: availability.TicketCode,
                                c_code: availability.ClassCode
                            }).first

                leg_1_av.price = price_var.PriceLeg1
                leg_2_av.price = price_var.PriceLeg2

                leg_1_av.save!
                leg_2_av.save!


            end

            # for each availability, we will create one for each leg, using the information 
            # from our c_flight, and information gathered from the price table

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
        
        dev_null = Logger.new("/dev/null")
        Rails.logger = dev_null
        ActiveRecord::Base.logger = dev_null

        Flight.destroy_all
        TicketAvailability.destroy_all

        FlightsRaw.all.each do |raw_flight|

            # Check for composite flights based on the stopover code
            # print(raw_flight.inspect)
            if raw_flight.StopOverCode != nil

                # Then we have a composite flight, so deal with it

                comp_flight = Flight.new
                flight_1 = Flight.new
                flight_2 = Flight.new

                comp_flight.flight_number = raw_flight.FlightNumber
                flight_1.flight_number = raw_flight.FlightNumber
                flight_2.flight_number = raw_flight.FlightNumber

                comp_flight.departure_time = raw_flight.DepartureTime
                comp_flight.arrival_time = raw_flight.ArrivalTime
                comp_flight.flight_time = raw_flight.Duration + raw_flight.DurationSecondLeg
                comp_flight.is_composite_flight = true
                comp_flight.destination_id = Destination.find_by(destination_code: raw_flight.DestinationCode).id
                comp_flight.origin_id = Destination.find_by(destination_code: raw_flight.DepartureCode).id
                comp_flight.airlines_id = Airline.find_by(airline_code: raw_flight.AirlineCode).id

                flight_1.departure_time = raw_flight.DepartureTime
                flight_1.arrival_time = raw_flight.ArrivalTimeStopOver
                flight_1.flight_time = raw_flight.Duration
                flight_1.is_composite_flight = false
                flight_1.destination_id = Destination.find_by(destination_code: raw_flight.StopOverCode).id
                flight_1.origin_id = Destination.find_by(destination_code: raw_flight.DepartureCode).id
                flight_1.airlines_id = Airline.find_by(airline_code: raw_flight.AirlineCode).id

                flight_2.departure_time = raw_flight.DepartureTimeStopOver
                flight_2.arrival_time = raw_flight.ArrivalTime
                flight_2.flight_time = raw_flight.DurationSecondLeg
                flight_2.is_composite_flight = false
                flight_2.destination_id = Destination.find_by(destination_code: raw_flight.DestinationCode).id
                flight_2.origin_id = Destination.find_by(destination_code: raw_flight.StopOverCode).id
                flight_2.airlines_id = Airline.find_by(airline_code: raw_flight.AirlineCode).id

                comp_flight.save!
                flight_1.save!
                flight_2.save!

                print("The id of flight one is #{flight_1.id}")
                print("The id of flight two is #{flight_2.id}")

                comp_flight.leg_1_id = flight_1.id
                comp_flight.leg_2_id = flight_2.id

                comp_flight.save!

                Availability.where("FlightNumber = :f_no AND DepartureTime = :d_time", {
                    f_no: raw_flight.FlightNumber, d_time: raw_flight.DepartureTime
                    }).find_each do |availability|


                    # We need a ticket availability for each flight, where the number of seats for the
                    # compostite flight is floored to the lowest number of seats for one of the legs

                    # First create the main availability
                    composite_ticket_availability = TicketAvailability.new
                    composite_ticket_availability.flight_id = comp_flight.id
                    composite_ticket_availability.ticket_type_id = TicketType.find_by(ticket_code: availability.TicketCode).id
                    composite_ticket_availability.ticket_class_id = TicketClass.find_by(class_code: availability.ClassCode).id
                    composite_ticket_availability.seats_available = [availability.NumberAvailableSeatsLeg1, availability.NumberAvailableSeatsLeg2].min
                   # begin
                    price = Price.where("FlightNumber = :f_no 
                            AND StartDate <= :av_date 
                            AND EndDate >= :av_date 
                            AND TicketCode = :tic_code
                            AND ClassCode = :c_code", {
                                f_no: comp_flight.flight_number, 
                                av_date: availability.DepartureTime,
                                tic_code: availability.TicketCode,
                                c_code: availability.ClassCode
                            }).first

                    composite_ticket_availability.price = price.Price
                   # rescue NoMethodError
                      #  composite_ticket_availability.price = -1
                    #end
                    composite_ticket_availability.save!

                    flight_1_ticket = TicketAvailability.new
                    flight_1_ticket.flight_id = comp_flight.id
                    flight_1_ticket.ticket_type_id = composite_ticket_availability.ticket_type_id
                    flight_1_ticket.ticket_class_id = composite_ticket_availability.ticket_class_id
                    flight_1_ticket.seats_available = availability.NumberAvailableSeatsLeg1
                    flight_1_ticket.price = price.PriceLeg1
                    flight_1_ticket.save!


                    flight_2_ticket = TicketAvailability.new
                    flight_2_ticket.flight_id = comp_flight.id
                    flight_2_ticket.ticket_type_id = composite_ticket_availability.ticket_type_id
                    flight_2_ticket.ticket_class_id = composite_ticket_availability.ticket_class_id
                    flight_2_ticket.seats_available = availability.NumberAvailableSeatsLeg2
                    flight_2_ticket.price = price.PriceLeg2
                    flight_2_ticket.save!

                end


            else

                # Else its a single flight

                # Create our new normal flight and populate its fields
                flight = Flight.new
                flight.flight_number = raw_flight.FlightNumber
                flight.departure_time = raw_flight.DepartureTime.to_s
                flight.arrival_time = raw_flight.ArrivalTime.to_s
                flight.flight_time = raw_flight.Duration
                flight.is_composite_flight = false
                flight.destination_id = Destination.find_by(destination_code: raw_flight.DestinationCode).id
                flight.origin_id = Destination.find_by(destination_code: raw_flight.DepartureCode).id
                flight.airlines_id = Airline.find_by(airline_code: raw_flight.AirlineCode).id

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
                   # begin
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
                    #rescue NoMethodError
                     #   ticket_availability.price = -1
                   # end
                    ticket_availability.save!

                end

            end

            



        end 

    end

end
