class AddOldRecordToLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :attendance_logs, :old_record_at, :datetime
  end
end
