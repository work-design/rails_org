class RemoveJobTitleColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :job_titles, :department_id
    remove_column :members, :job_title_id
  end
end
