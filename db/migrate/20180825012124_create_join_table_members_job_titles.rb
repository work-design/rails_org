class CreateJoinTableMembersJobTitles < ActiveRecord::Migration[5.2]
  def change
    create_join_table :members, :job_titles do |t|
      t.index [:member_id, :job_title_id]
      t.index [:job_title_id, :member_id]
    end
  end
end
