class AddNoteToExpense < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :note, :string, limit: 4096
    add_column :purchases, :note, :string, limit: 4096
  end
end
