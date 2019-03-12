class AddTrainingEndToInterviewee < ActiveRecord::Migration[5.2]
  def change
    add_column :interviewees, :training_end, :datetime
  end
end
