class EventsController < ApplicationController

  def new
    @event = Event.new
    @user = User.new
  end

  def create
    raise
  end
end
