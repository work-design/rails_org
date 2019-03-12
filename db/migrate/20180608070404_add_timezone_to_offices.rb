class AddTimezoneToOffices < ActiveRecord::Migration[5.2]
  def change
    add_column :offices, :timezone, :string
  end
end
