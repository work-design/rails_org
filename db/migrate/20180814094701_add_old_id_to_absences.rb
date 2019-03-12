class AddOldIdToAbsences < ActiveRecord::Migration[5.2]
  def change
    add_column :absences, :old_id, :integer
    add_column :absences, :old_state, :string
    add_column :absences, :old_type, :string
  end
end
