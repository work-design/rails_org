class AddLatedToAttendance < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :kind, :string
  end
end
