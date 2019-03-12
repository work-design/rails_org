class AddProcessedToAbsence < ActiveRecord::Migration[5.2]
  def change
    add_column :absences, :processed, :boolean, default: false
  end
end
