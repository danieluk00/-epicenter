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
    @user.organiser = true
    if @user.save && @event.persisted?
      redirect_to share_path + "?token=#{@event.event_token}"
    else
      render :new
    end
  end

  def share
    @event = Event.find_by(event_token: params[:token])

  end

  def join
    @event = Event.find_by(event_token: params[:event_token])
    @organiser = User.find_by(event: @event, organiser: true)
    @users = User.where(event: @event)
    @deadline
  end

  private

  def secure_params_event
    params.require(:event).permit(:event_name, :start_dt, :registration_deadline, :registration_deadline)
  end

  def secure_params_user
    params_sec = params.require(:event).permit(user: [:name, :address])
    params_sec[:user]
  end

end
