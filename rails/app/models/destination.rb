class Destination < ActiveRecord::Base
    belongs_to :country

=begin
    Define and override our as_json method in order to generate custom json
    This json will include the required attributes of the desination as well
    as the country
=end
    
    def as_json(options={})
        super(
            :only => [:destination_code, :airport],
            :include => {
                :country => {
                    :only => [:country_code_2, :country_code_3, :country_name, :alternate_name_1]
                }   
            }
        )
    end

end
