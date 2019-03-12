class RemoveAncestorsFromMembers < ActiveRecord::Migration[5.2]
  def change
    remove_column :members, :department_ancestors
  end
end
