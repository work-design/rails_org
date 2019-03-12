class RemoveOnTimeFromMember < ActiveRecord::Migration[5.2]
  def change
    remove_columns :members, :on_time, :off_time
  end
end
