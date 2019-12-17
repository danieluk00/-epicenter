class PagesController < ApplicationController
  def home
  end

  def confirmation
    @event = Event.find_by(event_token: params[:event])
    @epicentre = @event.epicentre

    @markers = @event.users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { user: user })
      }
    end
    @markers.push(@epicentre)
  end

  def waiting
    @event = Event.find_by(event_token: params[:event])
    @users = @event.users
    @organiser = User.find_by(event: @event, organiser: true)
  end
end
