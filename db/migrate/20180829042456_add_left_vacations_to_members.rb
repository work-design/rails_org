class AddLeftVacationsToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :vacation_balances, :float
  end
end
