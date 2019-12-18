class ChangeNameToIncludedInUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :included, :included_in_epicenter
  end
end
