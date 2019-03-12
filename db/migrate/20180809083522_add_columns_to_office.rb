class AddColumnsToOffice < ActiveRecord::Migration[5.2]
  def change
    add_column :offices, :contact, :string
    add_column :offices, :recruitment, :string
  end
end
