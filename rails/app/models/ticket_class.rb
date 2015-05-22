class TicketClass < ActiveRecord::Base

    belongs_to :ticket_availability

    # Override the as_json method to return our custom JSON
    def as_json(options={})
        super(
            :only => [:id, :class_code, :details]
        )
    end

end
