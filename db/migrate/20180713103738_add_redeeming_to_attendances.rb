class AddRedeemingToAttendances < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :absence_redeeming, :boolean
    add_column :absences, :redeeming, :boolean
  end
end
