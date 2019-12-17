require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  event = Event.create(event_name: 'Test event', start_dt: '16 Dec 2019 18:00')
  user = User.create(email: 'daniellandes@gmail.com', event: event)

  test "announce" do
    mail = UserMailer.with(event: event).announce
    assert_equal "Epicenter: the wait is over", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["no-reply@epicenter.live"], mail.from
   # assert_match "Hi", mail.body.encoded
  end

end
