class AddWorkdayToAttendance < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :workday, :boolean, default: true
  end
end
