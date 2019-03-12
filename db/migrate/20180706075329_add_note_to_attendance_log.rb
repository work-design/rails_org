class AddNoteToAttendanceLog < ActiveRecord::Migration[5.2]
  def change
    add_column :attendance_logs, :note, :string
  end
end
