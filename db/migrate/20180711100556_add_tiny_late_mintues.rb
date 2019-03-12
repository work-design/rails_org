class AddTinyLateMintues < ActiveRecord::Migration[5.2]

  def change
    add_column :attendance_stats, :tiny_late_minutes, :integer
    add_column :attendance_stats, :tiny_late_days, :integer
    rename_column :attendance_stats, :late_days, :normal_late_days

    remove_columns :attendance_stats, :final_late_minutes, :late_minutes, :leave_hours

    add_column :attendances, :absence_minutes, :integer
    remove_column :attendances, :final_late_minutes, :final_leave_minutes
  end

end
