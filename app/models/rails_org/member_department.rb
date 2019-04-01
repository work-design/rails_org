class MemberDepartment < ApplicationRecord
  belongs_to :member
  belongs_to :job_title
  belongs_to :department, optional: true
  belongs_to :office, optional: true
  #has_many :department_members, class_name: 'Member', foreign_key: :department_id, primary_key: :department_id
  has_many :same_department_followers, ->(o){ default_where('grade-lte': o.grade) }, class_name: self.name, foreign_key: :department_id, primary_key: :department_id

  has_taxons :department
  attribute :department_descendants

  before_save :sync_department_and_office, if: -> { job_title_id_changed? }

  def all_department_followers

  end

  def set_major
    self.class.transaction do
      self.update(major: true)
      self.class.where.not(id: self.id).where(member_id: self.member_id).update_all(major: false)
    end
  end

  def sync_department_and_office
    if job_title
      self.department_root_id = job_title.department_id
      self.office_id = job_title.office_id
      self.grade = job_title.grade
    end
  end

end
