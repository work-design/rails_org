class AddIntervalHoursToAttendances < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :interval_hours, :float
  end
end
