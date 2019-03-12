class AddReviewExamsToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :review_exams_count, :integer, default: 0
  end
end
