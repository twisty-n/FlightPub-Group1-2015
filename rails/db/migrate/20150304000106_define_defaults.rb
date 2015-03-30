class DefineDefaults < ActiveRecord::Migration
  def change
  	change_column :users, :fName, :string, :limit => 40, :null=> false, :default => ''
  end
end
