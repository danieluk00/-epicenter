class PagesController < ApplicationController
  def home
  end

  def share
  end

  def join
    @event = Event.find(params[:event_token])
  end

  def confirmation
    
  end
end
