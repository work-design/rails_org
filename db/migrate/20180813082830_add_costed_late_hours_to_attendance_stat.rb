class AddCostedLateHoursToAttendanceStat < ActiveRecord::Migration[5.2]
  def change

    add_column :attendance_stats, :cost_absence_hours, :float
    add_column :attendance_stats, :free_absence, :string, limit: 1024
    add_column :attendance_stats, :redeeming_absence, :string, limit: 1024
    change_column :attendance_stats, :costed_absence, :string, limit: 1024

  end
end
