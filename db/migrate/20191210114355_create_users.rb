class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :phone_number
      t.boolean :organiser
      t.string :address
      t.string :token
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
