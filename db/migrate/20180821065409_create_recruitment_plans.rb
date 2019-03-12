class CreateRecruitmentPlans < ActiveRecord::Migration[5.2]
  def change
    create_table :recruitment_plans do |t|
      t.integer :member_id
      t.integer :journal_id
      t.integer :ae_count
      t.integer :me_count
      t.string :state
      t.timestamps
    end
  end
end
