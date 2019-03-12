class CreateHrAbsenceStats < ActiveRecord::Migration[5.2]
  def change
    create_table :absence_stats do |t|
      t.references :member
      t.string :year
      t.float :annual_days
      t.float :annual_add
      t.float :left_annual_days
      t.float :vacation_days
      t.string :details, limit: 1024
      t.timestamps
    end
  end
end
