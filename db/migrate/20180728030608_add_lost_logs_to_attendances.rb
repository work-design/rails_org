class AddLostLogsToAttendances < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :lost_logs, :string
  end
end
