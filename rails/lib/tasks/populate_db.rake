require 'active_record/fixtures'

namespace :populate_db do

    desc "Insert a list of users that are all catching the same flight. Note that ticketing is not updated
    to reflect this. Only saved flights are modified"
    # This task will populate SAavedJourneys with purchase type journeys from a random journey in
    # the data
    task :enumerate_saved_flights => :environment do

        user_list = User.all

        # rand_record = Model.offset(offset).first
        offset = rand(Journey.count)
        our_journey_id = Journey.offset(offset).first.id

        print "\n\nJourney Id: #{our_journey_id}"
        print "User Id: #{user_list.first.id}\n\n"

        user_list.each do |user|

            # For each user, insert a record into the SavedJourneys table
            new_j = SavedJourney.new
            new_j.user_id = user.id
            new_j.journey_id = our_journey_id
            new_j.save_identifier_id = SaveIdentifier.purchased.first.id

            if not new_j.save!
                print "unable to save journey #{new_j.inspect}"
            end

        end

    end

    task :simulate_conversation => :environment do

        twisty = User.find_by email: 'tnew2294@gmail.com'
        matt = User.find_by email: 'matt@sikkema.com'

        convo = UserConversation.new
        convo.participant_1_id = twisty.id
        convo.participant_2_id = matt.id
        convo.message_count = 0

    end

end
