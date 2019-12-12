class PagesController < ApplicationController
  def home
  end


  def confirmation

  end

  def waiting
    @event = Event.find_by(event_token: params[:event])
    @organiser = User.find_by(event: @event, organiser: true)
  end
end
