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

        convo_list = Array.new

        # Create 12 new conversations
        12.times do 

            convo = UserConversation.new
            convo.participant_1_id = User.limit(20).order("RAND()").first.id
            convo.participant_2_id = User.limit(5).order("RAND()").reject{ |s| s.id == convo.participant_1_id }.first.id
            convo.message_count = 0;

            if convo.save
                print "saved"
            end

            convo_list.push(convo)

        end

        # having generated the conversations, we now need to populate them with some test messages
        UserConversation.all.each  do |conversation|

            # Create a conversation! with messages
            20.times do |index|

                users = [ conversation.participant_1_id, conversation.participant_2_id ]
                message = Message.new
                message.user_id = users.sample
                message.user_conversation_id = conversation.id
                message.content = "Message #{index} sent by user #{message.user_id}"
                
                # post the conversation to the message
                conversation.post_message(message)

            end
            

        end
        

    end

end
