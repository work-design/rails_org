class AddSoucrToAttendanceLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :attendance_logs, :source, :string
  end
end
