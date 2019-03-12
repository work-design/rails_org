class AddPaymentMethodToExpense < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :payment_method_id, :integer
    add_column :expenses, :payout_id, :integer
  end
end
