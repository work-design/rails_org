class AddCostAbsenceToAttendanceStat < ActiveRecord::Migration[5.2]
  def change
    add_column :attendance_stats, :costed_absence, :string
  end
end
