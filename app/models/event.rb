class Event < ApplicationRecord
  has_many :users

  validates :venue_type, presence: true
  validates :event_name, presence: true
  validates :start_dt, presence: true
  validates :registration_deadline, presence: true

  def has_venue?
    self.venue_name && self.venue_address && self.venue_rating && self.venue_map_link
  end

  def calc_epicentre
    if users.length == 0 # there are no invitees
      return false
    elsif latitude && longitude
      return { lat: latitude, lng: longitude }
    end

    return self if has_venue?

      # 1st calculating epicenter
      long_array = []
      lat_array = []

      organiser_location = [users.first.latitude, users.first.longitude]
      users_in_range = self.users.near(organiser_location, 40, units: :km)

      if users_in_range.length == 0 # the aren't invitees close
        return false
      else
        # We put inside the arrays the longitudes and latitudes
        users_in_range.each do |user|
          long_array.push(user.longitude) if user.longitude.present? && !user.longitude.nil?
          lat_array.push(user.latitude) if user.latitude.present? && !user.latitude.nil?
          user.included_in_epicenter = true
          user.save
      end

        event_longitude = long_array.sum / long_array.count
        event_latitude = lat_array.sum / lat_array.count

        # We create a client of the GPLACES API
        @client = GooglePlaces::Client.new(ENV["GPLACES_API_KEY"])
        # We take the 5 first places in a radio from 100 meters to 2000 meters
        radius=100
        places = []

        while places.length<=5 && radius<2000 do
          places = @client.spots(event_latitude, event_longitude, :radius => radius, :types => [venue_type.downcase])
          radius = radius * 2
        end

        # If we want to show always the best rated place uncomment next line
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
    def epicentre
      return @epicentre if @epicentre
      @epicentre = calc_epicentre
    end
  end




