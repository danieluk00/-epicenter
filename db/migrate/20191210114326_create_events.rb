class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :event_name
      t.string :venue_type
      t.date :start_dt
      t.date :registration_deadline
      t.integer :place_id
      t.string :possible_venues
      t.string :event_token

      t.timestamps
    end
  end
end
