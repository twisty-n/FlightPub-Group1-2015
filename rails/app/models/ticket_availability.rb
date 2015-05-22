class TicketAvailability < ActiveRecord::Base

    belongs_to :flight
    belongs_to :ticket_type
    belongs_to :ticket_class

    # Allow lookups of ticket availability based on the class code
    scope :t_class, -> (class_code) { joins(:ticket_class).where( ticket_classes: { class_code: class_code } )}
    scope :economy, -> { joins(:ticket_class).where( ticket_classes: { class_code: 'ECO' } )}
    scope :business, -> { joins(:ticket_class).where( ticket_classes: { class_code: 'BUS' } )}
    scope :premium_economy, -> { joins(:ticket_class).where( ticket_classes: { class_code: 'PME' } )}
    scope :first_class, -> { joins(:ticket_class).where( ticket_classes: { class_code: 'FIR' } )}

    # Allows lookups based on the type of ticket
    scope :type, -> (type_code) { joins(:ticket_type).where( ticket_types: { ticket_code: :type_code } ) }
    scope :platinum, ->  { joins(:ticket_type).where( ticket_types: { name: 'Platinum' } ) }
    scope :discounted, ->  { joins(:ticket_type).where( ticket_types: { name: 'Discounted' } ) }
    scope :standard, ->  { joins(:ticket_type).where( ticket_types: { name: 'Standard' } ) }
    scope :standby, ->  { joins(:ticket_type).where( ticket_types: { name: 'Standby' } ) }
    scope :premium, ->  { joins(:ticket_type).where( ticket_types: { name: 'Premium' } ) }
    scope :premium_discounted, ->  { joins(:ticket_type).where( ticket_types: { name: 'Premium Discounted' } ) }
    scope :ld, ->  { joins(:ticket_type).where( ticket_types: { name: 'ld' } ) }


    # Allow lookups based on the minimum number of seats that the availability needs to have
    scope :min_seats, -> (seats) { where('seats_available >= ?', seats) }

    # Allow lookups that find the minimum prices ticket
    scope :smallest_price, -> { order(price: :asc).first }

end
