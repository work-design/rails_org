class AddLateMinusToAttendance < ActiveRecord::Migration[5.2]
  def change
    add_column :attendance_stats, :late_minutes, :integer
    add_column :attendance_stats, :final_late_minutes, :integer
    rename_column :attendance_stats, :late_hours, :leave_hours
  end
end
