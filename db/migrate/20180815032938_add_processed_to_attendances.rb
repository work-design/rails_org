class AddProcessedToAttendances < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :processed, :boolean
    add_column :attendance_stats, :processed, :boolean
  end
end
