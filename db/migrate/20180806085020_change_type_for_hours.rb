class ChangeTypeForHours < ActiveRecord::Migration[5.2]
  def change
    change_column :attendance_stats, :redeeming_hours, :float
  end
end
