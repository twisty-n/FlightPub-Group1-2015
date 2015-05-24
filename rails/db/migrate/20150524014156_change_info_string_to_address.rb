class ChangeInfoStringToAddress < ActiveRecord::Migration
  def change
    rename_column :users, :info_string, :address
  end
end
