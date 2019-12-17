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
    # Puttin inside the arrays the longitudes and latitudes
    users.each do |user|
      # in case we have NIL longitude or latitude, we dont' use this location
      # but we validate to have a real place in the forms (event, invitee)
      long_array.push(user.longitude) if user.longitude
      lat_array.push(user.latitude) if user.latitude
    end
    event_longitude = long_array.sum / long_array.count
    event_latitude = lat_array.sum / lat_array.count

    # THIS IS THE GOOD CODE: WE ARE WORKING WITH HARD CODE IN places for testing
    # calling the G PLACES API
    # @client = GooglePlaces::Client.new(ENV["GPLACES_API_KEY"])
    # radius=100
    # places = []
    # while places.length<=5 && radius<2000 do
    #   places = @client.spots(event_latitude, event_longitude, :radius => radius, :types => ['bar'])
    #   radius = radius * 2
    # end

    @client = GooglePlaces::Client.new(ENV["GPLACES_API_KEY"])
    places = @client.spots(event_latitude, event_longitude, :radius => 10000, :types => ['bar'])


    aux = places.sort_by { |place| place.rating }.reverse.first(5)


    min_rating = 5
    short_list = []
    # while short_list.length < 3
    #   #short_list =  { |place| place.rating.to_i >= min_rating }
    #   min_rating -= 0.1
    # end

    # if final_place
    #   @event.place_id = final_place


      # @name = final_place.name
      # @address = final_place.formatted_address
      # @phone = final_place.formatted_phone_number
      # @rating = final_place.rating
      # @photo = final_place.photos

    raise
    # places.each do |spot|
    #   spot.name
    # end

    #@event.save



    # DON'T TOUCH THIS CODE!!!! IS FOR THE GOOGLE API
    # we save the value in the database
    # update(latitude: event_latitude, longitude: event_longitude)


    return {lat: event_latitude, lng: event_longitude}
    return { lat: event_latitude, lng: event_longitude }



  end

  def epicentre
    return @epicentre if @epicentre
    @epicentre = calc_epicentre
  end

end

