class PurchasedTicket < ActiveRecord::Base
  belongs_to :ticket_availability
  belongs_to :user
end
