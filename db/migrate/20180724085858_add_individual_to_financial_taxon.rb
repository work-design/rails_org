class AddIndividualToFinancialTaxon < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_taxons, :individual, :boolean, default: false
  end
end
