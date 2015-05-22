class Api::TicketClassesController < ApplicationController

    # Returns JSON form of all ticket classes, as below
=begin
   {"ticket_classes":
        [
            {"class_code":"BUS","details":"Business Class"},
            {"class_code":"ECO","details":"Economy"},
            {"class_code":"FIR","details":"First Class"},
            {"class_code":"PME","details":"Premium Economy"}
        ]
    }
=end
    def index
        render :json => TicketClass.all
    end
end