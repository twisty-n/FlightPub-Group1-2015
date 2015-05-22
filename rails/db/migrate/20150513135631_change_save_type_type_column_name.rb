class ChangeSaveTypeTypeColumnName < ActiveRecord::Migration
  def change
    rename_column :save_types, :type, :s_type
  end
end
