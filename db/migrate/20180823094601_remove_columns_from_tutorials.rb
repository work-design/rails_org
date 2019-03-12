class RemoveColumnsFromTutorials < ActiveRecord::Migration[5.2]
  def change
    rename_column :tutorials, :intern_begin_on, :start_on
    rename_column :tutorials, :probation_begin_on, :finish_on
    remove_columns :tutorials, :tutor_begin_on, :accepted_on, :merged_id, :divided
  end
end
