class EraseDeadlineInEvent < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :registration_deadline
  end
end
