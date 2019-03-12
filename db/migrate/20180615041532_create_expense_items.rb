class CreateExpenseItems < ActiveRecord::Migration[5.2]
  def change
    create_table :expense_items do |t|
      t.references :expense
      t.references :member
      t.references :financial_taxon
      t.decimal :budget, precision: 10, scale: 2
      t.decimal :amount, precision: 10, scale: 2
      t.string :note
      t.string :state
      t.timestamps
    end

    remove_columns :expense_members, :financial_taxon_id, :budget, :cost
  end
end
