class AddVenueFildsToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :venue_name, :string
    add_column :events, :venue_address, :string
    add_column :events, :venue_phone, :string
    add_column :events, :venue_photo_url, :string
    add_column :events, :venue_rating, :float
    remove_column :events, :possible_venues
    remove_column :events, :place_id
  end
end
