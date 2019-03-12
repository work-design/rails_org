class AddMergedIdToAbsences < ActiveRecord::Migration[5.2]
  def change
    add_column :absences, :merged_id, :integer
    add_column :absences, :divided, :boolean, default: false

    add_column :tutorials, :merged_id, :integer
    add_column :tutorials, :divided, :boolean, default: false
  end
end
