class AddBandToMembers < ActiveRecord::Migration[5.2]
  def change
    add_reference :members, :band
  end
end
