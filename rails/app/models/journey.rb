class Journey < ActiveRecord::Base
  belongs_to :user
  belongs_to :save_identifier
end
