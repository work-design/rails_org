class AddLocaleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :locale, :string
    add_column :offices, :locale, :string
  end
end
