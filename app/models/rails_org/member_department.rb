class MemberDepartment < ApplicationRecord
  belongs_to :member
  belongs_to :job_title
  belongs_to :department, optional: true
  belongs_to :office, optional: true
  #has_many :department_members, class_name: 'Member', foreign_key: :department_id, primary_key: :department_id
  has_many :same_department_followers, ->(o){ default_where('grade-lte': o.grade) }, class_name: self.name, foreign_key: :department_id, primary_key: :department_id

  has_taxons :department

  before_save :sync_department_and_office, if: -> { job_title_id_changed? }

  def sync_department_and_office
    if job_title
      self.department_root_id = job_title.department_id
      self.office_id = job_title.office_id
      self.grade = job_title.grade
    end
  end

end
