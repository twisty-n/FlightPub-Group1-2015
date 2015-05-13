class ReRenameSaveTypeTable < ActiveRecord::Migration
  def change
    rename_table :save_category, :save_identifiers
  end
end
