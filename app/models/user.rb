class User < ApplicationRecord
  belongs_to :event
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, presence: true
  validates :email, format: { with: /\A.*@.*\z/ }
  validates :address, presence: true
end
