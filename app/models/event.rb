class Event < ApplicationRecord
  has_many :users

  validates :venue_type, presence: true
  validates :event_name, presence: true
  validates :start_dt, presence: true
  validates :registration_deadline, presence: true


  def calc_epicentre
    if latitude && longitude
      set_instance_variables
      return {lat: latitude, lng: longitude}
    end

    # 1st calculating epicenter
    long_array = []
    lat_array = []

    organiser_location = [users.first.latitude, users.first.longitude]
    users_in_range = self.users.near(organiser_location, 40)
    # Puttin inside the arrays the longitudes and latitudes
    users_in_range.each do |user|
      long_array.push(user.longitude) if user.longitude
      lat_array.push(user.latitude) if user.latitude
      user.included_in_epicenter = true
      user.save
    end
    event_longitude = long_array.sum / long_array.count
    event_latitude = lat_array.sum / lat_array.count

    # calling the G PLACES API
    radius=100
    places = []
    @client = GooglePlaces::Client.new(ENV["GPLACES_API_KEY"])
    while places.length<=5 && radius<2000 do
      places = @client.spots(event_latitude, event_longitude, :radius => radius, :types => [venue_type.downcase])
      radius = radius * 2
    end
    
    # most_ratings = places.sort_by { |place| place.user_ratings_total }.reverse
    final_place = places.sort_by { |place| place.rating.to_f }.reverse.first(1)[0]

    # raise
    

    # saving all the information of the final_place
    latitude = final_place.lat
    longitude = final_place.lng
    self.venue_name = final_place.name
    self.venue_address = final_place.vicinity
    self.venue_phone = final_place.formatted_phone_number
    self.venue_photo_url = final_place.photos[0].fetch_url(800)
    self.venue_rating =  final_place.rating
    self.venue_map_link = final_place.place_id
    self.save

    return { lat: latitude, lng: longitude }
  end

  def epicentre
    return @epicentre if @epicentre
    @epicentre = calc_epicentre
  end
end

