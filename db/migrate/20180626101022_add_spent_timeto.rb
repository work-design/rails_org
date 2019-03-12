class AddSpentTimeto < ActiveRecord::Migration[5.2]
  def change
    add_column :exams, :spent_minutes, :integer
  end
end
