class EnqueueEmailJob < ApplicationJob
  queue_as :default

  def perform(event_token)
    event = Event.find_by(event_token: event_token)
    event.users.each do |user|
      UserMailer.with(event: event, user: user).announce.deliver_now
    end
  end
end
