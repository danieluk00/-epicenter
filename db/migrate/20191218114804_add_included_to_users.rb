class AddIncludedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :included, :boolean
  end
end
