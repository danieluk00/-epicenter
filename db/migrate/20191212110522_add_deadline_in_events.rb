class AddDeadlineInEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :registration_deadline, :integer
  end
end
