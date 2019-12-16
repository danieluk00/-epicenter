class PagesController < ApplicationController
  def home
  end

  def confirmation
    @event = Event.find(id=3)
    
    @epicentre = {
      lat: @event.latitude,
      lng: @event.longitude,
    }
    @markers = @event.users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
      }
    end
  end

  def waiting
    @event = Event.find_by(event_token: params[:event])
    @organiser = User.find_by(event: @event, organiser: true)
  end
end
