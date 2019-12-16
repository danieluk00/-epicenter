class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.announce.subject
  #
  def announce
    @user = params[:user] # Instance variable => available in view
    mail(to: @user.email, subject: 'Epicenter - location annoucement')
  end
end
