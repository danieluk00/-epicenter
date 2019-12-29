class Event < ApplicationRecord
  has_many :users

  validates :venue_type, presence: true
  validates :event_name, presence: true
  validates :start_dt, presence: true
  validates :registration_deadline, presence: true

  def has_venue?
    # Check if venue has already been generated
    self.venue_name && self.venue_address && self.venue_rating && self.venue_map_link
  end

  def epicentre
    return @epicentre if @epicentre # If epicenter already exists, return it
    @epicentre = calc_epicentre # Otherwise calculate the epicenter
  end

  def calc_epicentre
    if users.length == 0 # If there are no invitees, return false
      return false
    elsif latitude && longitude # Otherwise return epicenter lat and long
      return { lat: latitude, lng: longitude } 
    end

    return self if has_venue? # Guard clause to check if venue already is picked

    # Calculate the epicenter
    long_array = []
    lat_array = []

    # The organiser and users within 40km of the organiser and included in the epicenter
    organiser_location = [users.first.latitude, users.first.longitude]
    users_in_range = self.users.near(organiser_location, 40, units: :km)

    if users_in_range.length == 0 # If there are no users in range
      return false
    else
      # We iterate through each user in range, and add their lat and long to the array
      users_in_range.each do |user|
        long_array.push(user.longitude) if user.longitude.present? && !user.longitude.nil?
        lat_array.push(user.latitude) if user.latitude.present? && !user.latitude.nil?
        user.included_in_epicenter = true
        user.save
    end
      
    # The epicenter is then the average of the lats and longs
    event_longitude = long_array.sum / long_array.count
    event_latitude = lat_array.sum / lat_array.count

    # We create a client of the GPLACES API (Google Maps)
    @client = GooglePlaces::Client.new(ENV["GPLACES_API_KEY"])

    # We query Google for venues (of the chosen type) in a radius of 100 meters from the epicenter. If there are less than five, we double the radius and try again (to a max radius of 2000m).
    radius=100
    places = []
    while places.length<=5 && radius<2000 do
      places = @client.spots(event_latitude, event_longitude, :radius => radius, :types => [venue_type.downcase])
      radius = radius * 2
    end

    # We order the places returned by rating and randomly choose one place randomly from the top five.
    final_place = places.sort_by { |place| place.rating.to_f }.reverse.first(5).sample

    # We save all the information of the final_place
    self.latitude = final_place.lat
    self.longitude = final_place.lng
    self.venue_name = final_place.name
    self.venue_address = final_place.vicinity
    self.venue_phone = final_place.formatted_phone_number
    self.venue_photo_url = final_place.photos[0].fetch_url(800) if final_place.photos[0]
    self.venue_rating =  final_place.rating
    self.venue_map_link = final_place.place_id
    self.save
    return { lat: latitude, lng: longitude }
    end
    end

  end




