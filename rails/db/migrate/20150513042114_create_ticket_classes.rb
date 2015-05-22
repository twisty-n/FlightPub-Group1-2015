class CreateTicketClasses < ActiveRecord::Migration
  def change
    create_table :ticket_classes do |t|
      t.string :class_code
      t.string :details

      t.timestamps null: false
    end
  end
end
