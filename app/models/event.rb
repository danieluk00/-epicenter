class Event < ApplicationRecord
  has_many :users

  validates :venue_type, presence: true
  validates :event_name, presence: true
  validates :start_dt, presence: true
  validates :registration_deadline, presence: true


  def calc_epicentre
    # if latitude && longitude
    #   set_instance_variables
    #   return {lat: latitude, lng: longitude}
    # end

    # 1st calculating epicenter
    long_array = []
    lat_array = []
    # Puttin inside the arrays the longitudes and latitudes
    users.each do |user|
      # in case we have NIL longitude or latitude, we dont' use this location
      # but we validate to have a real place in the forms (event, invitee)
      long_array.push(user.longitude) if user.longitude
      lat_array.push(user.latitude) if user.latitude
    end
    event_longitude = long_array.sum / long_array.count
    event_latitude = lat_array.sum / lat_array.count


    # 2nd we choose if is a bar o cafe
    # @client = GooglePlaces::Client.new(ENV["GPLACES_API_KEY"])



    # calling the G PLACES API
    # radius=100
    # places = []
    # while places.length<=5 && radius<2000 do
    #   places = @client.spots(event_latitude, event_longitude, :radius => radius, :types => [venue_type.downcase])
    #   radius = radius * 2
    # end

    @client = GooglePlaces::Client.new(ENV["GPLACES_API_KEY"])
    places = @client.spots(event_latitude, event_longitude, :radius => 10000, :types => ["bar"])
    final_place = places.sort_by { |place| place.rating }.reverse.first(1)[0]

    # saving all the information of the final_place
    self.latitude = final_place.lat
    self.longitude = final_place.lng
    self.venue_name = final_place.name
    self.venue_address = final_place.formatted_address
    self.venue_phone = final_place.formatted_phone_number
    self.venue_photo_url = final_place.photos[0].fetch_url(800)
    self.venue_rating =  final_place.rating
    self.save!

raise

    return { lat: latitude, lng: longitude }
  end

  def epicentre
    return @epicentre if @epicentre
    @epicentre = calc_epicentre
  end
end

