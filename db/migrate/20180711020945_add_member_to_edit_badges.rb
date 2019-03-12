class AddMemberToEditBadges < ActiveRecord::Migration[5.2]
  def change
    rename_table :editor_badges, :member_badges
    add_reference :member_badges, :member
  end
end
