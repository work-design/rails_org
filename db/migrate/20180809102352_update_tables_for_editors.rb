class UpdateTablesForEditors < ActiveRecord::Migration[5.2]
  def change
    create_table :journal_rels do |t|
      t.references :journal
      t.references :member
    end
  end
end
