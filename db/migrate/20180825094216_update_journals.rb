class UpdateJournals < ActiveRecord::Migration[5.2]
  def change
    add_column :journals, :idatabases, :string
    add_column :journals, :editors, :string
  end
end
