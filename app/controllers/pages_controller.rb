class PagesController < ApplicationController
  def home
  end

  def confirmation
    @event = Event.find_by(event_token: params[:event])
    @users = @event.users
    @epicentre = @event.epicentre
    @markers = []
    if @epicentre
      @markers.push(@epicentre)
    else
      redirect_to cancelation_path + "?event=#{@event.event_token}"
    end
  end

  def waiting
    @event = Event.find_by(event_token: params[:event])
    @users = @event.users
    @organiser = User.find_by(event: @event, organiser: true)
    # we want to show all the confirmed users for this event
    @users = User.where(event: @event)
  end

  def optimising
    @event = Event.find_by(event_token: params[:event])
  end

  def cancelation
    @event = Event.find_by(event_token: params[:event])
  end

  def skipoptimising
    #redirect_to confirmation_path(@event) + "?event=#{@event.event_token}"
  end
end
