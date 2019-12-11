class ChangeDataToTimestampInEvent < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :start_dt, :datetime
    change_column :events, :registration_deadline, :datetime
  end
end
