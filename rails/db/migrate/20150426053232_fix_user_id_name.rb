class FixUserIdName < ActiveRecord::Migration
  def change
    # TODO: Note that this will have to be changed when reverting back to MYSQL
   # execute "ALTER TABLE \"users\" DROP CONSTRAINT users_pk"
   # add_column :users, :id, :primary_key
  end
end
