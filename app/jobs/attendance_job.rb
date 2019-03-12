class AttendanceJob < ApplicationJob
  queue_as :default

  def perform
    AttendanceLog.analyze

    Attendance.compute_summary!
    Attendance.notify_completion

    AttendanceStat.init
    AttendanceStat.compute_summary!
  end

end
