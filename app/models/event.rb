class Event < ApplicationRecord
  has_many :users


  validates :start_dt, presence: true

  # private

  def calc_epicentre
    if latitude && longitude 
      return {lat: latitude, lng: longitude}
    end

    long_array = []
    lat_array = []
    users.each do |user|
      long_array.push(user.longitude)
      lat_array.push(user.latitude)
    end
    # event_longitude = long_array.sum / long_array.count
    # event_latitude = lat_array.sum / lat_array.count
    event_longitude = (long_array.sort!.first + long_array.sort!.last) / 2
    event_latitude = (lat_array.sort!.first + lat_array.sort!.last) / 2
    update(latitude: event_latitude, longitude: event_longitude)
  
    return {lat: event_latitude, lng: event_longitude}
  end

  def epicentre
    return @epicentre if @epicentre
    @epicentre = calc_epicentre
  end

end

