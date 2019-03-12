class AddActualToPayout < ActiveRecord::Migration[5.2]
  def change
    add_column :payouts, :actual_amount, :decimal, precision: 10, scale: 2
    rename_column :payouts, :amount, :requested_amount
  end
end
