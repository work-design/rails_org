class RemovePurchases < ActiveRecord::Migration[5.2]
  def change
    drop_table :purchase_items
    drop_table :purchase_offices
    drop_table :purchases
  end
end
