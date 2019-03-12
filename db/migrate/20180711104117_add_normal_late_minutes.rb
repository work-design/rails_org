class AddNormalLateMinutes < ActiveRecord::Migration[5.2]
  def change
    add_column :attendance_stats, :normal_late_minutes, :integer
    add_column :attendance_stats, :meal_days, :integer
  end
end
