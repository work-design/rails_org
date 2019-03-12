class AddAttendHoursToAttendances < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :attend_hours, :float
  end
end
