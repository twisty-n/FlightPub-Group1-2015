class TicketAvailability < ActiveRecord::Base
    belongs_to :flight
    belongs_to :ticket_type
    belongs_to :ticket_class

    scope :class, -> (class_code) { joins(:ticket_class).where( ticket_classes: { class_code: class_code } )}

    

    scope :economy, -> { joins(:ticket_class).where( ticket_classes: { class_code: 'ECO' } )}
    scope :business, -> { joins(:ticket_class).where( ticket_classes: { class_code: 'BUS' } )}
    scope :premium_economy, -> { joins(:ticket_class).where( ticket_classes: { class_code: 'PME' } )}
    scope :first_class, -> { joins(:ticket_class).where( ticket_classes: { class_code: 'FIR' } )}
end
