class AddLateHoursToAttendance < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :absence_hours, :float
  end
end
