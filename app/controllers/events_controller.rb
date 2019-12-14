class EventsController < ApplicationController
require 'securerandom'

  def new
    @event = Event.new
    @user = User.new
  end

  def create
    @event = Event.new(secure_params_event)
    @event.event_token = SecureRandom.hex(10)
    @event.save
    @user = User.new(secure_params_user)
    @user.event = @event
    @user.token = SecureRandom.hex(10)
    @user.organiser = true
    if @user.save && @event.persisted?
      set_cookie
      redirect_to share_path + "?event=#{@event.event_token}&user=#{@user.token}"
    else
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    @event.latitude = @event.epicentre[0]
    @event.longitude = @event.epicentre[1]
    @event.update(secure_params_event)
    @event.save
    redirect_to confirmation_path(@event)
  end

  def share
    @event = Event.find_by(event_token: params[:event])
  end

  def join
    @event = Event.find_by(event_token: params[:event_token])
    @organiser = User.find_by(event: @event, organiser: true)
    @users = User.where(event: @event)
    @deadline
    if cookies[:epicenter] == @event.event_token
      redirect_to waiting_path + "?event=#{@event.event_token}"
    end
  end

  private

  def secure_params_event
    params.require(:event).permit(:event_name, :start_dt, :registration_deadline, :registration_deadline, :latitude, :longitude)
  end

  def secure_params_user
    params_sec = params.require(:event).permit(user: [:name, :address])
    params_sec[:user]
  end

  def set_cookie
    cookies.permanent[:epicenter] = @event.event_token
  end

end
