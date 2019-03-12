class AddBorrowToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :expense_members, :advance, :decimal, precision: 10, scale: 2
  end
end
