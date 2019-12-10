class EventsController < ApplicationController

  def new
    @event = Event.new
    @user = User.new
  end

  def create
  end
end
