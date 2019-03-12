class RemoveFinanlAttendance < ActiveRecord::Migration[5.2]
  def change
    remove_columns :attendances, :final_attend_hours, :absence_hours
  end
end
