class AddAttendanceHoursTo < ActiveRecord::Migration[5.2]
  def up
    add_column :attendances, :final_attend_hours, :float
  end

  def down
    remove_column :attendances, :final_attend_hours
  end
end
