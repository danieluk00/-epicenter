class AddSpinsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :spins, :integer
  end
end
