class AddTakeStockToFinancialTaxons < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_taxons, :take_stock, :boolean, default: false
  end
end
