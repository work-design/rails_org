class MemberJobTitle < ApplicationRecord
  belongs_to :member
  belongs_to :job_title
  belongs_to :department, optional: true
  belongs_to :office, optional: true
  has_many :department_members, class_name: 'Member', foreign_key: :department_id, primary_key: :department_id

  before_save :sync_department_and_office, if: -> { job_title_id_changed? }

  def sync_department_and_office
    if job_title
      self.department_id = job_title.department_id
      self.office_id = job_title.office_id
      self.grade = job_title.grade
    end
  end

end
