class AddPayoutTypeToPayouts < ActiveRecord::Migration[5.2]
  def change
    add_reference :payouts, :payable, polymorphic: true
    add_column :payouts, :advance, :boolean, default: false
  end
end
