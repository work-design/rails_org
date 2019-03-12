class AddColumnsToJournal < ActiveRecord::Migration[5.2]
  def change
    add_reference :journals, :office
    add_reference :journals, :department
  end
end
