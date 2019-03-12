class AddCountryToExtraDays < ActiveRecord::Migration[5.2]
  def change
    add_column :extra_days, :country, :string
  end
end
