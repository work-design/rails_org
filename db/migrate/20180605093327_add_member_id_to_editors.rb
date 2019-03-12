class AddMemberIdToEditors < ActiveRecord::Migration[5.2]
  def change
    add_reference :editors, :member
  end
end
