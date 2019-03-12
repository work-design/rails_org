class AddFinalLateMinutesToAttendances < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :final_late_minutes, :integer
    add_column :attendances, :final_leave_minutes, :integer
  end
end
