class PagesController < ApplicationController
  def home
  end

  def confirmation
    @markers = User.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
      }
      @epicentre = {
        lat: 41.405228,
        lng: 2.164524,
      }
    end
    p @markers.to_json
  end

  def waiting
    @event = Event.find_by(event_token: params[:event])
    @organiser = User.find_by(event: @event, organiser: true)
  end
end
