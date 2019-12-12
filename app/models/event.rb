class Event < ApplicationRecord
  has_many :users

  validates :start_dt, :start_dt_after_now, presence: true

  private

  def start_dt_after_now
    start_dt > Time.now
  end

  def epicentre
    @event = @event
    @users = @event.users
    long_array = []
    lat_array = []
    @users.each do |user|
      long_array.push(user.longitude)
      lat_array.push(user.latitude)
    end
    event_longitude = long_array.sum / long_array.count
    event_latitude = lat_array.sum / lat_array.count
    event_coordinates = [event_latitude, event_longitude]
  end

end

