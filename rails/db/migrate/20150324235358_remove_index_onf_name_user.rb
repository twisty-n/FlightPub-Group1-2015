class RemoveIndexOnfNameUser < ActiveRecord::Migration
  def change
  	remove_index :users, name: "index_users_on_fName"
  end
end
