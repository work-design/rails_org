class ChangeToRecruitmentPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :recruitment_plans, :comment, :text
    add_column :recruitment_plans, :rejected, :boolean
  end
end
