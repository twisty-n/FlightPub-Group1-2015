class SavedJourneySerializer < ActiveModel::Serializer
  
    attributes :journey, :save_type, :account_type

    def journey
        JourneySerializer.new(object.journey)
    end

    def save_type
        object.save_identifier.s_type
    end

    def account_type
       object.save_identifier.account_type
   end 

end