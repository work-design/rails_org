class AddFinancialTaxonId < ActiveRecord::Migration[5.2]
  def change
    add_reference :expenses, :financial_taxon
    remove_column :expenses, :comment

    add_column :expense_items, :quantity, :integer, default: 1
    add_column :expense_items, :price, :decimal, precision: 10, scale: 2
  end
end
