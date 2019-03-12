class AddPaymentMethodToPayout < ActiveRecord::Migration[5.2]
  def change
    add_column :payouts, :payment_method_id, :integer
  end
end
