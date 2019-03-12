class AddInvoicesCountToExpence < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :invoices_count, :integer
  end
end
