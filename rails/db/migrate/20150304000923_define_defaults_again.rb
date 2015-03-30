class DefineDefaultsAgain < ActiveRecord::Migration
  def change
  	change_column :users, :lName, :string, :limit => 40, :null=> false, :default => ''
  	change_column :users, :password, :string, :limit => 20, :null=> false, :default => 'password'
  end
end
