class PagesController < ApplicationController
  def home
  end

  def confirmation
    @event = Event.find_by(event_token: params[:event])
    @users = @event.users
    @epicentre = @event.epicentre
    # Set the markers array (the map points) as empty
    @markers = []
    if @epicentre
      @markers.push(@epicentre)  # Push the epicenter to the array
    else
      redirect_to cancelation_path + "?event=#{@event.event_token}" # If no epicenter generated, show cancellation page
    end
  end

  def waiting
    @event = Event.find_by(event_token: params[:event])
    @users = @event.users
    @organiser = User.find_by(event: @event, organiser: true)
    @users = User.where(event: @event) # We want to show all the confirmed users for this event
  end

  def optimising
    @event = Event.find_by(event_token: params[:event])
  end

  def cancelation
    @event = Event.find_by(event_token: params[:event])
  end

end
