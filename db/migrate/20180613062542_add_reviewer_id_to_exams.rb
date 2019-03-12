class AddReviewerIdToExams < ActiveRecord::Migration[5.2]
  def change
    add_column :exams, :reviewer_id, :integer
  end
end
