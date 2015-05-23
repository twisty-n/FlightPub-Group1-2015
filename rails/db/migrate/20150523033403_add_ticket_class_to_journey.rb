class AddTicketClassToJourney < ActiveRecord::Migration
  def change
    add_reference :journeys, :ticket_class, index: true
    add_foreign_key :journeys, :ticket_classes
  end
end
