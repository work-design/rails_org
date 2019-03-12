class CreateExamReviewers < ActiveRecord::Migration[5.2]
  def change
    create_table :exam_reviewers do |t|
      t.references :exam
      t.references :member
      t.references :reviewer
      t.timestamps
    end
  end
end
