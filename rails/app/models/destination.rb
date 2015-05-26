class Destination < ActiveRecord::Base
    belongs_to :country
    has_many :flights, class_name: "Flight", foreign_key: 'destination_id'
    has_many :flights, class_name: "Flight", foreign_key: 'origin_id'

    has_many :journeys, class_name: "Journey", foreign_key: 'destination_id'
    has_many :journeys, class_name: "Journey", foreign_key: 'origin_id'

=begin
    Define and override our as_json method in order to generate custom json
    This json will include the required attributes of the desination as well
    as the country
=end
    
    def as_json(options={})
        
        {   
            :id => self.id,
            :destination_code => self.destination_code,
            :airport => self.airport,
            :country_code_2 => self.country.country_code_2,
            :country_code_3 => self.country.country_code_3,
            :country_name => self.country.country_name,
            :alternate_name_1 => self.country.alternate_name_1
        }

    end 
        

end
