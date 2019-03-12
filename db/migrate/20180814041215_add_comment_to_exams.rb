class AddCommentToExams < ActiveRecord::Migration[5.2]

  def change
    add_column :exams, :comment, :string, limit: 1024
  end

end
