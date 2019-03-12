class ChangeColumnWithOnTime < ActiveRecord::Migration[5.2]
  def change
    remove_column :members, :next_on_time

    change_column :members, :on_time, :string
    change_column :members, :off_time, :string
  end
end
