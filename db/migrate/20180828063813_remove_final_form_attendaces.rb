class RemoveFinalFormAttendaces < ActiveRecord::Migration[5.2]
  def change
    remove_column :attendances, :final_leave_minutes
  end
end
