class CreateFinancialTaxonHierarchies < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_taxon_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :financial_taxon_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "financial_taxon_anc_desc_idx"

    add_index :financial_taxon_hierarchies, [:descendant_id],
      name: "financial_taxon_desc_idx"

    drop_table :purchase_taxon_hierarchies
  end
end
