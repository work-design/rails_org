class RemoveAuditorIdFromAbsence < ActiveRecord::Migration[5.2]
  def change
    remove_column :absences, :auditor_id
    remove_column :overtimes, :auditor_id
  end
end
