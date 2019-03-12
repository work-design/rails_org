class RenameFinanceMonth < ActiveRecord::Migration[5.2]
  def change
    rename_column :attendance_stats, :finance_month_id, :financial_month_id
  end
end
