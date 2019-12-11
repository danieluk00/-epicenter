class EventsController < ApplicationController
require 'securerandom'

  def new
    @event = Event.new
    @user = User.new
  end

  def create
    @event = Event.new(event_params)
    @event.event_token = SecureRandom.hex(10)
    @event.save!
  end
end
