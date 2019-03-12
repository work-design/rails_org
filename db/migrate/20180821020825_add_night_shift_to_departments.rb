class AddNightShiftToDepartments < ActiveRecord::Migration[5.2]
  def change
    add_column :departments, :night_shift, :boolean, default: false
  end
end
