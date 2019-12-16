class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.announce.subject
  #
  def announce
   @event = params[:event] # Instance variable => available in view
   emails = @event.users.map { |user| user.email }
   emails.each { |email| mail(to: email, subject: 'Epicenter: the wait is over') }
    # This will render a view in `app/views/user_mailer`!
  end
end
