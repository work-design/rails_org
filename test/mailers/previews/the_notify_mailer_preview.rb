# http://localhost:3000/rails/mailers/rails_notice_mailer_preview
class TheNotifyMailerPreview < ActionMailer::Preview

  def notify
    @notification = Notification.find 27
    TheNotifyMailer.notify @notification.id
  end

end
