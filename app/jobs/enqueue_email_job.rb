class EnqueueEmailJob < ApplicationJob
  queue_as :default

  def perform(event_token)
    event = Event.find_by(event_token: event_token)
    UserMailer.with(event: event).announce
  end
end
