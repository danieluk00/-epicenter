class User < ApplicationRecord
  belongs_to :event
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
