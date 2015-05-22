class AllowUsersToHaveNullName < ActiveRecord::Migration
  def change
        change_column :users, :first_name, :string, :limit => 40, :null=> true, :default => ''
  end
end
