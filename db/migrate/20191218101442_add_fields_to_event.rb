class AddFieldsToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :venue_url, :string
    add_column :events, :venue_map_link, :string
  end
end
