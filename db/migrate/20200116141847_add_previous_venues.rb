class AddPreviousVenues < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :previous_venue, :string
  end
end
