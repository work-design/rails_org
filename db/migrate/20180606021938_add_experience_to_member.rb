class AddExperienceToMember < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :experience, :text
  end
end
