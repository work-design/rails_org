class AddRecordStrToLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :attendance_logs, :record_at_str, :string
  end
end
