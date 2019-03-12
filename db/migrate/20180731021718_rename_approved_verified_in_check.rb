class RenameApprovedVerifiedInCheck < ActiveRecord::Migration[5.2]
  def change
    rename_column :checks, :approved, :verified
  end
end
