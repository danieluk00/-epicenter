class EventsController < ApplicationController
require 'securerandom'

  def new
    @event = Event.new
    @user = User.new
  end

  def create
    @event = Event.new(secure_params_event)
    @event = Event.new(event_params)
    @event.event_token = SecureRandom.hex(10)
    @event.save
    @user = User.new(secure_params_user)
    @user.event = @event
    @user.organiser = true
    if @user.save
      redirect_to root_path
    else
      render :new
    end
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
