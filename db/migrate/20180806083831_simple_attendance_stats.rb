class SimpleAttendanceStats < ActiveRecord::Migration[5.2]
  def change
    remove_columns :attendance_stats, :normal_late_minutes, :tiny_late_minutes, :tiny_late_days, :meal_days, :compensatory_hours

    rename_column :attendance_stats, :normal_late_days, :late_days
    rename_column :attendance_stats, :overtime_hours, :redeeming_hours
  end
end
