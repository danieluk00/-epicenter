class ChangeRegistrationDeadlineToString < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :registration_deadline, :string
  end
end
