class EventsController < ApplicationController

  def new
    @event = Event.new
    @user = User.new
  end

  def create

    @event = Event.new()
  end

  private

  def secure_params
    params.require(:event).permit(:event_name, :start_dt, :registration_deadline)
    params.require(:user).permit(:name, :addres)
  end

end
