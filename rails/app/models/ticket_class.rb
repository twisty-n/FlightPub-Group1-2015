class TicketClass < ActiveRecord::Base

    # Override the as_json method to return our custom JSON
    def as_json(options={})
        super(
            :only => [:class_code, :details]
        )
    end

end
