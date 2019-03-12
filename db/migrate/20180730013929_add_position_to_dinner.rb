class AddPositionToDinner < ActiveRecord::Migration[5.2]

  def change
    add_column :dinners, :position, :integer
  end

end
