class AddOvertimeMinsToAttendance < ActiveRecord::Migration[5.2]
  def change
    add_column :attendance_stats, :overtime_hours, :integer
  end
end
