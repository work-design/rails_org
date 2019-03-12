class AttendanceMailer < ApplicationMailer
  default from: 'training@mdpi.com'

  def normal_completion(member_id)
    @attendances = Attendance.where(member_id: member_id, finish_at: nil).where.not(start_at: nil)
    @member = Member.find member_id
    mail to: @member.email, subject: '[Admin] You have lost attendance logs, pleas re-punch on system!'
  end

  def interval_completion(member_id)
    @attendances = Attendance.where(member_id: member_id, interval_finish_at: nil).where.not(interval_start_at: nil)
    @member = Member.find member_id
    mail to: @member.email, subject: '[Admin] You have lost attendance logs, pleas re-punch on system!'
  end

end