class AddPayoutIdToExpenseMember < ActiveRecord::Migration[5.2]
  def change
    add_reference :expense_members, :payout
    add_reference :payouts, :operator
  end
end
