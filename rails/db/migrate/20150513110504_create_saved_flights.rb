class CreateSavedFlights < ActiveRecord::Migration
  def change

    # Allows multiple save types
    # E.g. Saved flights, common flights, purchased flights,
    # Also allows expansion in the future
    create_table :save_types do |t|
        t.string :type
        # Will change this later to acually use a table and all
        t.string :account_type
    end

    create_table :saved_flights do |t|
        t.belongs_to :flight, index: true
        t.belongs_to :user, index: true
        t.belongs_to :save_type, index: true
    end

  end
end
