class FixCountryMotherCountryName < ActiveRecord::Migration
  def change
    rename_column :countries, :mother_county_comment, :mother_country_comment
  end
end
