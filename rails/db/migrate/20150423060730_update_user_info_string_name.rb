class UpdateUserInfoStringName < ActiveRecord::Migration
  def change
    rename_column :users, :infoString, :info_string
  end
end
