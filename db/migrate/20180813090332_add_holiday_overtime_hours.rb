class AddHolidayOvertimeHours < ActiveRecord::Migration[5.2]
  def change
    add_column :attendance_stats, :holiday_redeeming_hours, :float
    rename_column :attendance_stats, :redeeming_hours, :absence_redeeming_hours
  end
end
