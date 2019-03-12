class SmsJob < ApplicationJob
  queue_as :default

  def perform(mobile, msg)
    SmsHelper.send_sms(mobile, msg)
  end

end
