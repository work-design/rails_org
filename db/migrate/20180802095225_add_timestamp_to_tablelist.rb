class AddTimestampToTablelist < ActiveRecord::Migration[5.2]
  def change
    add_column :table_lists, :timestamp, :string
  end
end
