class CreateHrAttendanceStats < ActiveRecord::Migration[5.2]
  def change
    create_table :attendance_stats do |t|
      t.references :member
      t.references :finance_month
      t.integer :allowance_days
      t.integer :late_days
      t.decimal :late_hours, precision: 10, scale: 1
      t.decimal :compensatory_hours, precision: 10, scale: 1
      t.timestamps
    end
  end
end
