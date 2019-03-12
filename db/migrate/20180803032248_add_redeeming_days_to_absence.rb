class AddRedeemingDaysToAbsence < ActiveRecord::Migration[5.2]
  def change
    add_column :absences, :redeeming_days, :string
  end
end
