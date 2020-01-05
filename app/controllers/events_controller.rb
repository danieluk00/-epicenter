class EventsController < ApplicationController
require 'securerandom'

  def new
    @event = Event.new
    @user = User.new
  end

  def create
    # Create the event
    @event = Event.new(secure_params_event)
    @event.event_token = SecureRandom.hex(10)
    # Create the first user and assign them to the event as organiser
    create_organiser
    # Save the user and event
    if @user.save && @event.save
      set_cookie
      redirect_to share_path + "?event=#{@event.event_token}&user=#{@user.token}"
    else
      render :new
    end
  end

  def endwaiting
    # Update the registration deadline to none so countdown ends immediately
    @event = Event.find_by(event_token: params[:event_token])
    @event.registration_deadline = 'none'
    @event.save
    # Then redirect to optimising page
    redirect_to optimising_path(@event) + "?event=#{@event.event_token}"
  end

  def share
    @event = Event.find_by(event_token: params[:event])
  end

  def refresh_users
    respond_to do |format|
      format.html
      format.js
    end
  end

  def join
    # When a user joins an event
    @event = Event.find_by(event_token: params[:event_token])
    @organiser = User.find_by(event: @event, organiser: true)
    @users = User.where(event: @event)

    if cookies["event+#{@event.event_token}"] == 'true'
      redirect_to waiting_path + "?event=#{@event.event_token}"
    end
  end

  private

  def secure_params_event
    params.require(:event).permit(:venue_type, :event_name, :start_dt, :registration_deadline, :registration_deadline, :latitude, :longitude)
  end

  def secure_params_user
    params_sec = params.require(:event).permit(user: [:name, :address])
    params_sec[:user]
  end

  def set_cookie
    cookies.permanent["event+#{@event.event_token}"] = 'true'
  end

  def create_organiser
    @user = User.new(secure_params_user)
    @user.event = @event
    @user.token = SecureRandom.hex(10)
    @user.organiser = true
    @user.included_in_epicenter = true
  end

  def spinagain
    puts 'Spin again'
    @event.venue_name = nil
    @event.venue_address = nil
    @event.venue_rating = nil
    @event.venue_map_link = nil
    @event.latitude = nil
    @event.longitude = nil
    @event.save
  end

end
