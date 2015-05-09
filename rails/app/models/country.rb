class Country < ActiveRecord::Base
    self.primary_key=:country_code_3
    has_many :destinations
end
