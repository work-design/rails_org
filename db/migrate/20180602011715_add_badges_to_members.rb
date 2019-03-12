class AddBadgesToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :badges, :string
  end
end
