class RenamePurchaseTaxon < ActiveRecord::Migration[5.2]
  def change
    rename_table :purchase_taxons, :financial_taxons
    rename_column :purchases, :purchase_taxon_id, :financial_taxon_id

    add_reference :expense_members, :financial_taxon
    add_column :expense_members, :budget, :decimal, precision: 10, scale: 2
    add_column :expense_members, :note, :string
  end
end
