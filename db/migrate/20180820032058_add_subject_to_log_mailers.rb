class AddSubjectToLogMailers < ActiveRecord::Migration[5.2]
  def change
    add_column :log_mailers, :subject, :string
    change_column_default :attendances, :processed, false
    change_column_default :attendance_stats, :processed, false
  end
end
