class RemovePayoutIdFromExpenseMembers < ActiveRecord::Migration[5.2]
  def change
    remove_columns :expense_members, :payout_id, :advance_payout_id
  end
end
