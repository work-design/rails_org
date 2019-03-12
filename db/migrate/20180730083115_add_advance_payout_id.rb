class AddAdvancePayoutId < ActiveRecord::Migration[5.2]
  def change
    add_column :expense_members, :advance_payout_id, :integer
  end
end
