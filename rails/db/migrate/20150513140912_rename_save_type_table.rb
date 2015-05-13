class RenameSaveTypeTable < ActiveRecord::Migration
  def change
    rename_table :save_type, :save_category
  end
end
