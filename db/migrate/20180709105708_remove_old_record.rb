class RemoveOldRecord < ActiveRecord::Migration[5.2]
  def change
    remove_column :attendance_logs, :old_record_at
    remove_column :absences, :compensatory

    add_column :attendances, :interval_absence_id, :integer
    add_column :attendances, :late_absence_id, :integer
    add_column :attendances, :leave_absence_id, :integer
  end
end
