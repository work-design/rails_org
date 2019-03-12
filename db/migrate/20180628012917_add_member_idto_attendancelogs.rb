class AddMemberIdtoAttendancelogs < ActiveRecord::Migration[5.2]
  def change
    add_reference :attendance_logs, :member
    rename_column :attendance_logs, :status, :state
  end
end
