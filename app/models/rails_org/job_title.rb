class JobTitle < ApplicationRecord
  acts_as_list column: :grade, scope: [:department_id, :office_id], top_of_list: 0

  attribute :name, :string
  attribute :grade, :integer

  belongs_to :department, optional: true
  belongs_to :office, optional: true
  has_many :member_departments

  after_update_commit :sync_grade_member_departments, if: -> { saved_change_to_grade? }

  def sync_grade_member_departments
    member_departments.update_all(grade: self.grade)
  end

end
