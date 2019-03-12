class CreateOaAttendanceSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :attendance_settings do |t|
      t.references :member
      t.references :financial_month
      t.string :on_time
      t.string :off_time
      t.string :state
      t.string :note
      t.timestamps
    end

    remove_column :members, :next_off_time, :next_on_time
  end
end
